import 'package:blabla/main_common.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';
import '../../states/ride_preferences_state.dart';
import '../../../utils/animations_util.dart';
import '../../theme/theme.dart';
import '../../widgets/pickers/ride_preference/bla_ride_preference_picker.dart';
import '../rides_selection/rides_selection_screen.dart';
import 'widgets/home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class HomeScreen extends StatefulWidget {
  final ServiceLocator serviceLocator;
  final RidePreferencesState ridePreferencesState;
  const HomeScreen({
    super.key,
    required this.serviceLocator,
    required this.ridePreferencesState,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RidePreference? _selectedPreference;
  List<RidePreference> _preferenceHistory = [];
  static const int _maxAllowedSeats = 8;

  @override
  void initState() {
    super.initState();
    widget.ridePreferencesState.addListener(_onRidePreferencesChanged);
    _loadPreferences();
  }

  @override
  void dispose() {
    widget.ridePreferencesState.removeListener(_onRidePreferencesChanged);
    super.dispose();
  }

  void _onRidePreferencesChanged() {
    setState(() {
      _selectedPreference = widget.ridePreferencesState.selectedPreference;
      _preferenceHistory = widget.ridePreferencesState.preferenceHistory;
    });
  }

  Future<void> _loadPreferences() async {
    await widget.ridePreferencesState.load();

    if (!mounted) return;
    _onRidePreferencesChanged();
  }

  void onRidePrefSelected(RidePreference selectedPreference) async {
    // 1- Save the preference via global state
    await widget.ridePreferencesState.selectPreference(selectedPreference);

    // 2 - Navigate to the rides screen
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(
        RidesSelectionScreen(
          serviceLocator: widget.serviceLocator,
          ridePreferencesState: widget.ridePreferencesState,
        ),
      ),
    );

    // 3 - After wait  - Update the state   - TODO Improve this with proper state managagement
    await _loadPreferences();
  }

  @override
  Widget build(context) {
    return Stack(children: [_buildBackground(), _buildForeground()]);
  }

  Widget _buildForeground() {
    return Column(
      children: [
        // 1 - THE HEADER
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: _selectedPreference,
                maxSeat: _maxAllowedSeats,
                serviceLocator: widget.serviceLocator,
                onRidePreferenceSelected: onRidePrefSelected,
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory() {
    // Reverse the history of preferences
    List<RidePreference> history = _preferenceHistory.reversed.toList();
    return SizedBox(
      height: 200, // Set a fixed height
      child: ListView.builder(
        shrinkWrap: true, // Fix ListView height issue
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: history[index],
          onPressed: () => onRidePrefSelected(history[index]),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
