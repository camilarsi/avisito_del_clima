import '../../Core/Resources/states.dart';
import '../Entities/app_location.dart';

abstract class ILocationRepository {
  Future<DataState<AppLocation>> getLocation(AppLocation location);
}
