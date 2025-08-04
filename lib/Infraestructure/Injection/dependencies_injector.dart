import 'package:avisito_del_clima/Data/Datasources/location_datasource.dart';
import 'package:avisito_del_clima/Data/Datasources/weather_api_datasource.dart';
import 'package:avisito_del_clima/Data/Repositories/weather_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Domain/Usecases/get_current_weather.dart';
import '../../Presentation/Blocs/location_bloc.dart';
import '../../Presentation/Blocs/weather_bloc.dart';

class DependenciesInjector {
  static final DependenciesInjector _injector =
      DependenciesInjector._internal();

  factory DependenciesInjector() => _injector;

  late final GetCurrentWeather _getCurrentWeather;
  late final LocationBloc _locationBloc;
  late final WeatherBloc _weatherBloc;
  late final WeatherAPIDataSource _weatherAPIDataSource;
  late final LocationDeviceDataSource _locationDataSource;
  final httpClient = http.Client();

  DependenciesInjector._internal() {
    final weatherApiKey = dotenv.env['WEATHER_API_KEY'];
    _weatherAPIDataSource = WeatherAPIDataSource(
      client: httpClient,
      apiKey: weatherApiKey!,
    );
    final repository = WeatherRepository(
      weatherAPIDataSource: _weatherAPIDataSource,
    );
    _getCurrentWeather = GetCurrentWeather(weatherRepository: repository);
    _locationDataSource = LocationDeviceDataSource();
    _locationBloc = LocationBloc(locationDeviceDataSource: _locationDataSource);
    _weatherBloc = WeatherBloc(
      getCurrentWeather: _getCurrentWeather,
      locationBloc: _locationBloc,
    );
  }

  LocationBloc get locationBloc => _locationBloc; // TODO remove
  WeatherBloc get weatherBloc => _weatherBloc;
}
