import '../../Core/Resources/states.dart';
import '../Entities/location.dart';
import '../Entities/weather.dart';

abstract class IWeatherRepository {
  Future<DataState<Weather>> getCurrentWeather(Location location);
}
