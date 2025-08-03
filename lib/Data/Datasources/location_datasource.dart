import '../../Domain/Entities/app_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class LocationDeviceDataSource {
  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<AppLocation> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();

    return AppLocation(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  Stream<AppLocation> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).map(
      (pos) => AppLocation(latitude: pos.latitude, longitude: pos.longitude),
    );
  }

  Future<AppLocation> getLocationFromCityName(String cityName) async {
    try {
      List<geocoding.Location> locations = await geocoding.locationFromAddress(
        cityName,
      );
      if (locations.isNotEmpty) {
        final location = locations.first;
        return AppLocation(
          latitude: location.latitude,
          longitude: location.longitude,
        );
      }
      throw Exception(
        'No se pudo encontrar la ubicación para: $cityName',
      ); // TODO const
    } catch (e) {
      throw Exception('Error buscando ubicación: $e');
    }
  }
}
