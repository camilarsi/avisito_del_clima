import 'package:avisito_del_clima/Core/Resources/states.dart';
import 'package:avisito_del_clima/Domain/Entities/location.dart';
import 'package:avisito_del_clima/Domain/Repositories/i_location_repository.dart';

import '../Datasources/location_datasource.dart';

class LocationRepository implements ILocationRepository {
  final LocationDataSource locationDataSource;

  LocationRepository({required this.locationDataSource});

  @override
  Future<DataState<Location>> getLocation(Location location) {
    // TODO: implement getLocation
    throw UnimplementedError();
  }

  //Future<DataState<Location>> getLocation(String location) async {}
}
