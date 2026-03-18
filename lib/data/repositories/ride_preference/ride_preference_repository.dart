import 'package:blabla/model/ride_pref/ride_pref.dart';

/// Abstract repository for managing ride preference data operations
abstract class RidePreferenceRepository {
  /// Get the currently selected preference
  Future<RidePreference?> getSelectedPreference();

  /// Save a preference
  Future<void> savePreference(RidePreference preference);

  /// Get preference history
  Future<List<RidePreference>> getPreferenceHistory();

  /// Clear preference history
  Future<void> clearHistory();
}
