import 'dart:core';

import 'package:flutter/material.dart';

class UIConstants {
  static const String appTitle = 'Tiempito';
  static const String waitingLocationMessage = 'Esperando ubicacion';
  static const String locationPermissionDialogTitle = 'Permisos de ubicación';
  static const String locationPermissionRequest =
      'Puedes buscar el tiempo de cualquier ciudad, o permitir el acceso a tu ubicación';
  static const String searchButton = 'Buscar';
  static const String givPermissionButton = 'Permitir';
  static const String currWeatherHeaderTitle = 'Tiempo';
  static const String citySearchBar = 'Ciudad';
  static const String citySearchBarHint = 'Ej: Buenos Aires, Madrid, etc.';
  static const String weatherDetailsSectionTitle = 'Detalles';
}

enum AppColors {
  primary(Color(0xFF26A69A)),
  secondary(Color(0xFF80CBC4)),
  accent(Color(0xFFFDC93A)),
  foreground(Color(0xFFFFFCF1)),
  dark(Color(0xFF10404E));

  final Color color;

  const AppColors(this.color);

  Color get getColor => color;
}

class WeatherIcons {
  static const Map<String, IconData> conditionToIcon = {
    "Sunny": Icons.wb_sunny_rounded,
    "Clear": Icons.nightlight,
    "Partly cloudy": Icons.cloud_queue,
    "Cloudy": Icons.cloud,
    "Overcast": Icons.filter_drama,
    "Mist": Icons.blur_on,
    "Patchy rain possible": Icons.grain,
    "Patchy snow possible": Icons.ac_unit,
    "Patchy sleet possible": Icons.grain,
    "Patchy freezing drizzle possible": Icons.grain,
    "Thundery outbreaks possible": Icons.flash_on,
    "Blowing snow": Icons.ac_unit,
    "Blizzard": Icons.ac_unit,
    "Fog": Icons.blur_on,
    "Freezing fog": Icons.blur_on,
    "Patchy light drizzle": Icons.grain,
    "Light drizzle": Icons.grain,
    "Freezing drizzle": Icons.ac_unit,
    "Heavy freezing drizzle": Icons.ac_unit,
    "Patchy light rain": Icons.grain,
    "Light rain": Icons.grain,
    "Moderate rain at times": Icons.grain,
    "Moderate rain": Icons.grain,
    "Heavy rain at times": Icons.grain,
    "Heavy rain": Icons.grain,
    "Light freezing rain": Icons.ac_unit,
    "Moderate or heavy freezing rain": Icons.ac_unit,
    "Light sleet": Icons.ac_unit,
    "Moderate or heavy sleet": Icons.ac_unit,
    "Patchy light snow": Icons.ac_unit,
    "Light snow": Icons.ac_unit,
    "Patchy moderate snow": Icons.ac_unit,
    "Moderate snow": Icons.ac_unit,
    "Patchy heavy snow": Icons.ac_unit,
    "Heavy snow": Icons.ac_unit,
    "Ice pellets": Icons.ac_unit,
    "Light rain shower": Icons.grain,
    "Moderate or heavy rain shower": Icons.grain,
    "Torrential rain shower": Icons.grain,
    "Light sleet showers": Icons.ac_unit,
    "Moderate or heavy sleet showers": Icons.ac_unit,
    "Light snow showers": Icons.ac_unit,
    "Moderate or heavy snow showers": Icons.ac_unit,
    "Light showers of ice pellets": Icons.ac_unit,
    "Moderate or heavy showers of ice pellets": Icons.ac_unit,
    "Patchy light rain with thunder": Icons.flash_on,
    "Moderate or heavy rain with thunder": Icons.flash_on,
    "Patchy light snow with thunder": Icons.flash_on,
    "Moderate or heavy snow with thunder": Icons.flash_on,
  };

  static IconData getIcon(String condition) {
    return conditionToIcon[condition] ?? Icons.wb_cloudy;
  }
}

class AppFontSizes {
  static const double xs = 14.0;
  static const double sm = 16.0;
  static const double md = 18.0;
  static const double lg = 20.0;
  static const double xl = 30.0;
  static const double xxl = 40.0;
  static const double xxXl = 50.0;
}
