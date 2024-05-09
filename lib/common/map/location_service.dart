

import 'package:background_locator/common/map/location_dto.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static const LocationDto initLocation = LocationDto(latitude: 37.545150, longitude: 126.922929);

  Future<LocationPermission> hasLocationPermission() async => await Geolocator.checkPermission();

  Future<bool> isLocationEnabled() async => await Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> requestLocation() async => await Geolocator.requestPermission();

  Future<LocationDto> currentLocation() async {
    final Position _position = await Geolocator.getCurrentPosition();
    return LocationDto(latitude: _position.latitude, longitude: _position.longitude);
  }

  Future<bool> canGetCurrentLocation() async {
    final LocationPermission _permission = await this.hasLocationPermission();
    if (_permission == LocationPermission.always || _permission == LocationPermission.whileInUse) {
      final bool _enabled = await this.isLocationEnabled();
      if (_enabled) return true;
    }
    return false;
  }
}