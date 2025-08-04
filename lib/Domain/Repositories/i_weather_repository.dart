import '../../Core/Resources/states.dart';
import '../Entities/app_location.dart';
import '../Entities/weather.dart';

abstract class IWeatherRepository {
  Future<DataState<Weather>> getCurrentWeather(AppLocation location);
}
