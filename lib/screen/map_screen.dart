import 'package:background_locator/common/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: const NaverMapViewOptions(
          mapType: NMapType.basic,
          locationButtonEnable: true,
          initialCameraPosition: NCameraPosition(
              target: NLatLng(36.326114, 127.397069),
              zoom: 15
          ),
          minZoom: 6,
          maxZoom: 16
      ),
      onMapReady: (controller) {
        print('============= ${DummyData.list.length}');
        for (var model in DummyData.list) {
          print(model.name);
          final marker = NMarker(
            id: model.name,
            icon: const NOverlayImage.fromAssetImage('asset/img/carMarkerImg.png'),
            position: NLatLng(model.lat, model.lot),
            size: Size(50, 50),
          );
          print('222');
          marker.setOnTapListener((overlay) {
            controller.updateCamera(NCameraUpdate.scrollAndZoomTo(target: overlay.position));
          });
          print('3');
          // marker.setMinZoom(13);
          // marker.setIsMinZoomInclusive(true);
          // marker.setMaxZoom(17);
          // marker.setIsMaxZoomInclusive(false);
          print('4');
          controller.addOverlay(marker);

          print('5');
          final onMarkerInfoWindow =
          NInfoWindow.onMarker(id: marker.info.id, text: model.name);
          marker.openInfoWindow(onMarkerInfoWindow);
        }
        print('=============');
      },
      onCameraChange: (NCameraUpdateReason reason, bool animated) {
        print(':::: onCameraChange');
      },
      onCameraIdle: () {

      },
    );
  }
}
