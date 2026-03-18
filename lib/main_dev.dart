import 'package:flutter/material.dart';
import 'main_common.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';
import 'ui/states/ride_preferences_state.dart';

void main() {
  final locator = ServiceLocator();
  locator.setupMock();
  final ridePreferencesState = RidePreferencesState(
    repository: locator.ridePreferenceRepository,
  );
  runApp(
    BlaBlaApp(
      serviceLocator: locator,
      ridePreferencesState: ridePreferencesState,
    ),
  );
}

class BlaBlaApp extends StatelessWidget {
  final ServiceLocator serviceLocator;
  final RidePreferencesState ridePreferencesState;
  const BlaBlaApp({
    super.key,
    required this.serviceLocator,
    required this.ridePreferencesState,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(
        body: HomeScreen(
          serviceLocator: serviceLocator,
          ridePreferencesState: ridePreferencesState,
        ),
      ),
    );
  }
}
