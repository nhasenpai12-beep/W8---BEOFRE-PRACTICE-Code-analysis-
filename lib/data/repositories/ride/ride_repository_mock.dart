import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'ride_repository.dart';

/// Mock implementation of RidesRepository using fake data
class RidesRepositoryMock extends RidesRepository {
  @override
  Future<List<Ride>> getAllRides() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return fakeRides;
  }

  @override
  Future<List<Ride>> getRidesFor(RidePreference preferences) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return fakeRides
        .where(
          (ride) =>
              ride.departureLocation == preferences.departure &&
              ride.arrivalLocation == preferences.arrival &&
              ride.availableSeats >= preferences.requestedSeats,
        )
        .toList();
  }
}
