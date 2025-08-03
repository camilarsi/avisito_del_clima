import 'dart:async';

import 'package:avisito_del_clima/Domain/Usecases/get_current_weather.dart';
import 'package:avisito_del_clima/Presentation/Blocs/location_bloc.dart';

import '../../Domain/Entities/weather.dart';

class WeatherStateError extends WeatherState {
  final String error;

  WeatherStateError({required this.error});
}

class WeatherStateSuccessful extends WeatherState {
  final Weather weather;

  WeatherStateSuccessful({required this.weather});
}

class WeatherStateLoading extends WeatherState {}

abstract class WeatherState {}

class WeatherBloc {
  final GetCurrentWeather getCurrentWeather;
  final LocationBloc locationBloc;

  final _streamController = StreamController<WeatherState>.broadcast();

  Stream<WeatherState> get state => _streamController.stream;

  late final StreamSubscription _locationSubscription;

  WeatherBloc({required this.getCurrentWeather, required this.locationBloc}) {
    _locationSubscription = locationBloc.locationState.listen(
      _onLocationChanged,
    );
  }

  void _onLocationChanged(LocationState locationState) async {
    if (locationState is LocationLoaded) {
      final location = locationState.location;
      _streamController.add(WeatherStateLoading());

      try {
        final weather = await getCurrentWeather(location);
        _streamController.add(WeatherStateSuccessful(weather: weather));
      } catch (e) {
        _streamController.add(
          WeatherStateError(error: 'Error obteniendo clima: ${e.toString()}'),
        );
      }
    } else if (locationState is LocationError) {
      _streamController.add(
        WeatherStateError(
          error: 'Error en ubicacion: ${locationState.message}',
        ),
      );
    } else {
      print(
        'WeatherBloc: Estado de ubicación no procesado: ${locationState.runtimeType}',
      );
    }
  }

  void dispose() {
    _locationSubscription.cancel();
    _streamController.close();
  }
}
