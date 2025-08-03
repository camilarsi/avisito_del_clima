import 'package:avisito_del_clima/Domain/Entities/weather.dart';

class WeatherModel {
  final String city;
  final double temperature;

  //final String description;

  WeatherModel({
    required this.city,
    required this.temperature,
    // required this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['location']['name'],
      temperature: json['current']['temp_c'],
      // description: json['description'],
    );
  }

  Weather toEntity(WeatherModel model) {
    return Weather(
      city: model.city,
      temperature: model.temperature,
      //  description: model.description,
    );
  }
}
