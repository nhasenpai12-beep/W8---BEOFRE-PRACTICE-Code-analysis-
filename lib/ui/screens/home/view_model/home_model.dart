import 'package:flutter/foundation.dart';
import 'package:blabla/main_common.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import '../../../states/ride_preferences_state.dart';

/// View model for the Home screen.
class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required this.serviceLocator,
    required this.ridePreferencesState,
  });

  final ServiceLocator serviceLocator;
  final RidePreferencesState ridePreferencesState;

  static const int maxAllowedSeats = 8;

  RidePreference? _selectedPreference;
  List<RidePreference> _preferenceHistory = [];

  RidePreference? get selectedPreference => _selectedPreference;
  List<RidePreference> get preferenceHistory =>
      List<RidePreference>.unmodifiable(_preferenceHistory);

  void startListening() {
    ridePreferencesState.addListener(_onRidePreferencesChanged);
    _syncFromState();
  }

  void stopListening() {
    ridePreferencesState.removeListener(_onRidePreferencesChanged);
  }

  Future<void> load() async {
    await ridePreferencesState.load();
    _syncFromState();
    notifyListeners();
  }

  Future<void> selectPreference(RidePreference preference) async {
    await ridePreferencesState.selectPreference(preference);
    _syncFromState();
    notifyListeners();
  }

  void _onRidePreferencesChanged() {
    _syncFromState();
    notifyListeners();
  }

  void _syncFromState() {
    _selectedPreference = ridePreferencesState.selectedPreference;
    _preferenceHistory = ridePreferencesState.preferenceHistory;
  }
}
