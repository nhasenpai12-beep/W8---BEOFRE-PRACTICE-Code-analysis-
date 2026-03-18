import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

/// Abstract repository for managing rides data operations
abstract class RidesRepository {
  /// Get all available rides
  Future<List<Ride>> getAllRides();

  /// Get rides that match the given preferences
  Future<List<Ride>> getRidesFor(RidePreference preferences);
}
