import 'package:avisito_del_clima/Core/Resources/states.dart';

import '../../Data/Repositories/weather_repository.dart';
import '../Entities/app_location.dart';
import '../Entities/weather.dart';

class GetCurrentWeather {
  final WeatherRepository weatherRepository;

  GetCurrentWeather({required this.weatherRepository});

  Future<Weather> call(AppLocation location) async {
    final result = await weatherRepository.getCurrentWeather(location);

    switch (result) {
      case DataSuccess(data: final weather):
        return weather;
      case DataFailure(message: final msg):
        throw Exception(msg);
      case _:
        throw Exception('Unknown error');
    }
  }
}
