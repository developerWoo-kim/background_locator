
import 'package:flutter_naver_map/flutter_naver_map.dart';

class LocationDto extends NLatLng {
  final double latitude;
  final double longitude;

  const LocationDto({required this.latitude, required this.longitude}) : super(latitude, longitude);
}