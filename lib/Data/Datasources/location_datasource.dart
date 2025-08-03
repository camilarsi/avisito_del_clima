import 'package:flutter/services.dart';

import '../Models/location_model.dart';

class LocationDataSource {
  static const EventChannel _locationChannel = EventChannel('location_channel');

  Stream<LocationModel> get locationStream {
    return _locationChannel.receiveBroadcastStream().map(
      (dynamic event) =>
          LocationModel.fromJson(Map<String, dynamic>.from(event)),
    );
  }

  //TODO implement location permission granted flag
  /*Future<LocationModel> getCurrentLocationOnce(){}*/
}
