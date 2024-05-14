import 'package:background_locator/common/data/dummy_data.dart';
import 'package:background_locator/common/util/app_bar_util.dart';
import 'package:background_locator/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapScreen extends StatefulWidget {
  const NaverMapScreen({super.key});

  @override
  State<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        appBar: AppBarUtil.buildAppBar(AppBarType.TEXT_TITLE, title: '네이버맵'),
        body: Center(
          child: NaverMap(
            options: const NaverMapViewOptions(
              // mapType: NMapType.navi, default = basic
              locationButtonEnable: true,
              initialCameraPosition: NCameraPosition(
                target: NLatLng(36.33618408, 127.394369),
                zoom: 15
              ),
              minZoom: 6,
              maxZoom: 16
            ),
            onMapReady: (controller) {
              controller = controller;
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
                controller.addOverlay(marker);

                final onMarkerInfoWindow =
                NInfoWindow.onMarker(id: marker.info.id, text: model.name);
                marker.openInfoWindow(onMarkerInfoWindow);
              }
              print('=============');

            },
          ),
        )
    );
  }
}
