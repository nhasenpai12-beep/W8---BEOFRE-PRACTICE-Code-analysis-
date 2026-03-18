import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'ride_preference_repository.dart';

/// Mock implementation of RidePreferenceRepository
class RidePreferenceRepositoryMock extends RidePreferenceRepository {
  RidePreference? _selectedPreference;
  final List<RidePreference> _preferenceHistory = [];

  @override
  Future<RidePreference?> getSelectedPreference() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _selectedPreference;
  }

  @override
  Future<void> savePreference(RidePreference preference) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    _selectedPreference = preference;
    if (!_preferenceHistory.contains(preference)) {
      _preferenceHistory.add(preference);
    }
  }

  @override
  Future<List<RidePreference>> getPreferenceHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _preferenceHistory;
  }

  @override
  Future<void> clearHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    _preferenceHistory.clear();
  }
}
