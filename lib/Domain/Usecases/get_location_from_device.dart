import '../Entities/location.dart';
import '../Repositories/i_location_repository.dart';

class GetLocationFromDevice {
  final ILocationRepository locationRepository;

  GetLocationFromDevice({required this.locationRepository});

  Future<Location> getLocationFromDevice() async {
    return Location(latitude: 0, longitude: 0); // TODO implement
  }
}
