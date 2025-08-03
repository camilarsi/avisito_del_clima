import '../../Core/Resources/states.dart';
import '../Entities/location.dart';

abstract class ILocationRepository {
  Future<DataState<Location>> getLocation(Location location);
}
