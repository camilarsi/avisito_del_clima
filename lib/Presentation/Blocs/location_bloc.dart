import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:avisito_del_clima/Data/Datasources/location_datasource.dart';
import '../../Domain/Entities/app_location.dart';

sealed class LocationEvent {}

class LocationRequestPermission extends LocationEvent {}

class LocationStartTracking extends LocationEvent {}

class LocationCheckPermissionStatus extends LocationEvent {}

class LocationSelectedManually extends LocationEvent {
  final AppLocation location;

  LocationSelectedManually({required this.location});
}

class LocationSearchByCity extends LocationEvent {
  final String cityName;

  LocationSearchByCity({required this.cityName});
}

sealed class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationPermissionDenied extends LocationState {}

class LocationLoaded extends LocationState {
  final AppLocation location;

  LocationLoaded(this.location);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}

class LocationBloc {
  final LocationDeviceDataSource locationDeviceDataSource;
  final _stateController = StreamController<LocationState>.broadcast();
  final _eventController = StreamController<LocationEvent>();

  Stream<LocationState> get locationState => _stateController.stream;

  Sink<LocationEvent> get sink => _eventController.sink;

  StreamSubscription<AppLocation>? _locationSubscription;

  LocationBloc({required this.locationDeviceDataSource}) {
    _eventController.stream.listen(_onEvent);
    _stateController.add(LocationInitial());
    _onEvent(LocationCheckPermissionStatus());
  }

  void _onEvent(LocationEvent event) async {
    if (event is LocationCheckPermissionStatus) {
      try {
        final currentPermission = await Geolocator.checkPermission();
        final isGranted =
            currentPermission == LocationPermission.always ||
            currentPermission == LocationPermission.whileInUse;

        if (isGranted) {
          _onEvent(LocationStartTracking());
        } else {
          _stateController.add(LocationPermissionDenied());
        }
      } catch (e) {
        _stateController.add(LocationError(e.toString()));
      }
    }

    if (event is LocationRequestPermission) {
      final granted = await locationDeviceDataSource.requestPermission();
      if (!granted) {
        _stateController.add(LocationPermissionDenied());
        return;
      }
      _onEvent(LocationStartTracking());
    }
    if (event is LocationStartTracking) {
      _stateController.add(LocationLoading());
      try {
        _locationSubscription?.cancel();
        final location = await locationDeviceDataSource.getCurrentLocation();

        _stateController.add(LocationLoaded(location));

        _locationSubscription = locationDeviceDataSource
            .getLocationStream()
            .listen(
              (newLocation) {
                _stateController.add(LocationLoaded(newLocation));
              },
              onError: (error) {
                _stateController.add(LocationError(error.toString()));
              },
            );
      } catch (e) {
        _stateController.add(LocationError(e.toString()));
      }
    }

    if (event is LocationSelectedManually) {
      _stateController.add(LocationLoading());

      try {
        _stateController.add(LocationLoaded(event.location));
      } catch (e) {
        _stateController.add(LocationError(e.toString()));
      }
    }

    if (event is LocationSearchByCity) {
      _stateController.add(LocationLoading());

      try {
        final location = await locationDeviceDataSource.getLocationFromCityName(
          event.cityName,
        );

        _stateController.add(LocationLoaded(location));
      } catch (e) {
        _stateController.add(LocationError(e.toString()));
      }
    }
  }
}
