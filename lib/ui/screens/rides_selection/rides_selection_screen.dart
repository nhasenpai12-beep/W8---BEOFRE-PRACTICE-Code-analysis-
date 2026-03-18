import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../utils/animations_util.dart' show AnimationUtils;
import '../../theme/theme.dart';
import '../../widgets/pickers/location/bla_ride_preference_modal.dart';
import 'widgets/rides_selection_header.dart';
import 'widgets/rides_selection_tile.dart';
import 'package:blabla/main_common.dart';
///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RidesSelectionScreen extends StatefulWidget {
  final ServiceLocator serviceLocator;
  const RidesSelectionScreen({super.key, required this.serviceLocator});

  @override
  State<RidesSelectionScreen> createState() => _RidesSelectionScreenState();
}

class _RidesSelectionScreenState extends State<RidesSelectionScreen> {
  RidePreference? _selectedPreference;
  List<Ride> _matchingRides = [];
  static const int _maxAllowedSeats = 8;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefsRepo = widget.serviceLocator.ridePreferenceRepository;
    final ridesRepo = widget.serviceLocator.ridesRepository;

    final selected = await prefsRepo.getSelectedPreference();
    if (selected == null) {
      if (!mounted) return;
      setState(() {
        _selectedPreference = null;
        _matchingRides = [];
      });
      return;
    }

    final rides = await ridesRepo.getRidesFor(selected);
    if (!mounted) return;
    setState(() {
      _selectedPreference = selected;
      _matchingRides = rides;
    });
  }
  void onBackTap() {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

    RidePreference? get selectedRidePreference => _selectedPreference;

    List<Ride> get matchingRides => _matchingRides;

  void onPreferencePressed() async {
    // 1 - Navigate to the rides preference picker
    final currentPreference = selectedRidePreference;
    if (currentPreference == null) return;

    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(
              initialPreference: currentPreference,
              maxSeat: _maxAllowedSeats,
              serviceLocator: widget.serviceLocator,
            ),
          ),
        );

    if (newPreference != null) {
      // 2 - Ask the service to update the current preference
      await widget.serviceLocator.ridePreferenceRepository
          .savePreference(newPreference);

      // 3 -   Update the widget state  - TODO Improve this with proper state managagement
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedRidePreference == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: selectedRidePreference!,
              onBackPressed: onBackTap,
              onFilterPressed: onFilterPressed,
              onPreferencePressed: onPreferencePressed,
            ),
        
            SizedBox(height: 100),
        
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: matchingRides[index],
                  onPressed: () => onRideSelected(matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
