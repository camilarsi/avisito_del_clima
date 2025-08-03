import 'package:avisito_del_clima/Core/Utils/ui_constants.dart';
import 'package:avisito_del_clima/Domain/Entities/weather.dart';

class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
  final double wind;
  final int humidity;
  final double uv;
  final double feelsLike;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.wind,
    required this.uv,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['location']['name'],
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      humidity: json['current']['humidity'],
      wind: json['current']['wind_kph'],
      uv: json['current']['uv'],
      feelsLike: json['current']['feelslike_c'],
    );
  }

  Weather toEntity() {
    return Weather(
      city: city,
      temperature: temperature,
      condition: condition,
      humidity: humidity,
      wind: wind,
      uv: uv,
      feelsLike: feelsLike,
      icon: WeatherIcons.getIcon(condition),
    );
  }
}
