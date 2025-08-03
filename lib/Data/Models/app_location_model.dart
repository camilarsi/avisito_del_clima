import '../../Domain/Entities/app_location.dart';

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({required this.latitude, required this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  AppLocation toEntity() {
    return AppLocation(latitude: latitude, longitude: longitude);
  }
}
