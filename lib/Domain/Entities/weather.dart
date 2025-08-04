import 'package:flutter/cupertino.dart';

class Weather {
  final String city;
  final double temperature;
  final String condition;
  final double wind;
  final int humidity;
  final double uv;
  final double feelsLike;
  final Icon icon;

  Weather({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.wind,
    required this.uv,
    required this.feelsLike,
    required this.icon,
  });
}
