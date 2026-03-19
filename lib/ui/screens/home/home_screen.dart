import 'package:blabla/main_common.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';
import '../../states/ride_preferences_state.dart';
import '../../../utils/animations_util.dart';
import '../rides_selection/rides_selection_screen.dart';
import 'view_model/home_model.dart';
import 'widgets/home_content.dart';

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
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      serviceLocator: widget.serviceLocator,
      ridePreferencesState: widget.ridePreferencesState,
    );
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.startListening();
    _loadPreferences();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.stopListening();
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  Future<void> _loadPreferences() async {
    await _viewModel.load();
  }

  void onRidePrefSelected(RidePreference selectedPreference) async {
    // 1- Save the preference via view model
    await _viewModel.selectPreference(selectedPreference);

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
    return HomeContent(
      viewModel: _viewModel,
      onRidePrefSelected: onRidePrefSelected,
    );
  }
}
