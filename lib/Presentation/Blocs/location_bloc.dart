import 'dart:async';

import 'package:avisito_del_clima/Domain/Usecases/get_location_from_device.dart';

import '../../Domain/Entities/location.dart';

class LocationEventManuallySelected extends LocationEvent {
  final Location location;

  LocationEventManuallySelected({required this.location});
}

class LocationEventFromDevice extends LocationEvent {}

class LocationEvent {}

class LocationStateLoading extends LocationState {}

class LocationStateError extends LocationState {
  final String errorMessage;

  LocationStateError({required this.errorMessage});
}

class LocationStateSuccessful extends LocationState {
  final Location location;

  LocationStateSuccessful({required this.location});
}

class LocationState {}

class LocationBloc {
  final GetLocationFromDevice getLocationFromDevice;

  final _stateController = StreamController<LocationState>.broadcast();
  final _eventController = StreamController<LocationEvent>();

  Stream<LocationState> get locationState => _stateController.stream;

  Sink<LocationEvent> get sink => _eventController.sink;

  LocationBloc({required this.getLocationFromDevice}) {
    _eventController.stream.listen(_onEvent);
  }

  void _onEvent(LocationEvent event) async {
    _stateController.add(LocationStateLoading());

    try {
      if (event is LocationEventManuallySelected) {
        final location = event.location;
        _stateController.add(LocationStateSuccessful(location: location));
      }
    } catch (e) {
      throw Exception("Unhandled LocationEvent");
    }
  }
}
