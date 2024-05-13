
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationProvider = StateNotifierProvider<LocationStateNotifier, LocationModelBase?>((ref) => LocationStateNotifier());

class LocationStateNotifier extends StateNotifier<LocationModelBase?> {
  LocationStateNotifier()
      : super(LocationModelLoading()) {
    getLocation();
  }

  Future<void> getLocation() async {
    final access = await Permission.location.status;
    debugPrint('Access ::: ${access.name}');
    if(access == PermissionStatus.granted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      state = LocationModel(latitude: position.latitude, longitude: position.longitude);
    } else {
      state = LocationModel(latitude: 36.326114, longitude: 127.397069);
    }
  }

  Future<void> changeLocation({required double latitude, required double longitude}) async{
    debugPrint('changeLocation ::: ');
    state = LocationModelLoading();
    state = LocationModel(latitude: latitude, longitude: longitude);
  }

}