import 'package:avisito_del_clima/Domain/Entities/weather.dart';

import '../../Core/Resources/states.dart';
import '../../Domain/Entities/location.dart';
import '../../Domain/Repositories/i_weather_repository.dart';
import '../Datasources/weather_api_datasource.dart';
import '../Models/weather_model.dart';

class WeatherRepository extends IWeatherRepository {
  final WeatherAPIDataSource weatherAPIDataSource;

  WeatherRepository({required this.weatherAPIDataSource});

  @override
  Future<DataState<Weather>> getCurrentWeather(Location location) async {
    try {
      final json = await weatherAPIDataSource.fetchWeather(location);
      final weatherModel = WeatherModel.fromJson(json);
      final weather = weatherModel.toEntity(weatherModel);
      return DataSuccess(data: weather);
    } catch (e) {
      return DataFailure(
        message: 'No se pudo obtener el clima', // TODO create consts
        exception: e is Exception ? e : null,
      );
    }
  }
}
