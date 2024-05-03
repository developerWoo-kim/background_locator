
import 'package:background_locator/util/background_locator2/custom_location_service_repository.dart';
import 'package:background_locator_2/location_dto.dart';

@pragma('vm:entry-point')
class CustomLocationCallbackHandler {
  @pragma('vm:entry-point')
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    CustomLocationServiceRepository myLocationCallbackRepository = CustomLocationServiceRepository();
    await myLocationCallbackRepository.init(params);
  }

  @pragma('vm:entry-point')
  static Future<void> disposeCallback() async {
    CustomLocationServiceRepository myLocationCallbackRepository = CustomLocationServiceRepository();
    await myLocationCallbackRepository.dispose();
  }

  @pragma('vm:entry-point')
  static Future<void> callback(LocationDto locationDto) async {
    CustomLocationServiceRepository myLocationCallbackRepository = CustomLocationServiceRepository();
    await myLocationCallbackRepository.callback(locationDto);
  }

  @pragma('vm:entry-point')
  static Future<void> notificationCallback() async {
    print('***notificationCallback');
  }
}