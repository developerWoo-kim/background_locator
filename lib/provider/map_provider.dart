

import 'package:background_locator/common/map/location_dto.dart';
import 'package:background_locator/common/map/location_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapProvider = ChangeNotifierProvider<MapProvider>((ref) {
  return MapProvider();
});

class MapProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();
  final LocationDto initLocation = LocationService.initLocation;

  MapProvider(){
    Future(this.setCurrentLocation);
  }

  NLocationTrackingMode _trackingMode = NLocationTrackingMode.none;
  NLocationTrackingMode get trackingMode => _trackingMode;
  set trackingMode(NLocationTrackingMode m) => throw "error";

  Future<void> setCurrentLocation() async {
    if (await _locationService.canGetCurrentLocation()){
      _trackingMode = NLocationTrackingMode.follow;
      notifyListeners();
    }
  }

}