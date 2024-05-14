
import 'package:background_locator/model/map_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapInfoProvider = AutoDisposeStateNotifierProvider<MapInfoStateNotifier, MapInfoModelBase?>((ref) => MapInfoStateNotifier());

class MapInfoStateNotifier extends StateNotifier<MapInfoModelBase?> {
  MapInfoStateNotifier()
      : super(MapInfoModelEmptyData());

  Future<void> getMapInfo() async {

  }

  Future<void> changeMapInfo({required String title, required String address, required String image}) async{
    state = MapInfoModel(title: title, address: address, image: image);
  }

  Future<void> clear() async {
    state = MapInfoModelEmptyData();
  }

}