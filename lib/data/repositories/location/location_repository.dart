import 'package:blabla/model/ride/locations.dart';

/// Abstract repository for managing location data operations
abstract class LocationsRepository {
  /// Get all available locations
  Future<List<Location>> getAvailableLocations();
}
