import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/model/ride/locations.dart';
import 'location_repository.dart';

/// Mock implementation of LocationsRepository using fake data
class LocationsRepositoryMock extends LocationsRepository {
  @override
  Future<List<Location>> getAvailableLocations() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return fakeLocations;
  }
}
