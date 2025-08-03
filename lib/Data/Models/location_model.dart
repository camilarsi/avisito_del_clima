import '../../Domain/Entities/location.dart';

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

  Location toEntity(LocationModel model) {
    return Location(latitude: model.latitude, longitude: model.longitude);
  }
}
