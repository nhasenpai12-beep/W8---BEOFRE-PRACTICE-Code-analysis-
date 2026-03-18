import 'package:blabla/data/repositories/location/location_repository.dart';
import 'package:blabla/data/repositories/location/location_repository_mock.dart';
import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/data/repositories/ride/ride_repository_mock.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository_mock.dart';

/// Service locator for dependency injection
/// This allows flexible environments (dev, staging, production)
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();

  factory ServiceLocator() {
    return _instance;
  }

  ServiceLocator._internal();

  late LocationsRepository _locationsRepository;
  late RidesRepository _ridesRepository;
  late RidePreferenceRepository _ridePreferenceRepository;

  /// Initialize repositories with mock implementations
  void setupMock() {
    _locationsRepository = LocationsRepositoryMock();
    _ridesRepository = RidesRepositoryMock();
    _ridePreferenceRepository = RidePreferenceRepositoryMock();
  }

  // Getters for repositories
  LocationsRepository get locationsRepository => _locationsRepository;
  RidesRepository get ridesRepository => _ridesRepository;
  RidePreferenceRepository get ridePreferenceRepository =>
      _ridePreferenceRepository;
}
