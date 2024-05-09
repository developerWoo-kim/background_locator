import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapScreen extends StatefulWidget {
  const NaverMapScreen({super.key});

  @override
  State<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  NaverMapController? controller;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!this.mounted) return;
    //   this.widget.mapProvider.myMarkers.forEach((CustomMarker marker) {
    //     marker.createImage(context);
    //     marker.setOnMarkerTab((naver.Marker marker, Map<String, int> iconSize) async {
    //       this._showBottomSheet = true;
    //       this.widget.mapProvider.onTapMarker(marker.markerId);
    //       await this._ct?.moveCamera(naver.CameraUpdate.scrollTo(marker.position));
    //     });
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '네이버맵',
        body: Center(
          child: NaverMap(
            options: const NaverMapViewOptions(
              // mapType: NMapType.navi, default = basic
              locationButtonEnable: true,
              initialCameraPosition: NCameraPosition(
                target: NLatLng(37.506932467450326, 127.05578661133796),
                zoom: 10
              ),
              minZoom: 6,
              maxZoom: 16

            ),
            onMapReady: (controller) {
              controller = controller;
              final marker = NMarker(
                id: 'test',
                icon: const NOverlayImage.fromAssetImage('asset/img/carMarkerImg.png'),
                position: const NLatLng(37.506932467450326, 127.05578661133796),
                size: Size(50, 50),
              );

              marker.setOnTapListener((overlay) {
                controller.updateCamera(NCameraUpdate.scrollAndZoomTo(target: overlay.position));
              });



              // final circle = NCircleOverlay(id: "test", center: const NLatLng(36.3552978000, 127.4186789000));
              // final line = NPolylineOverlay(id: "test", coords: [NLatLng(36.3552978000, 127.4186789000), NLatLng(36.3552897000, 127.4186769000)]);
              // final imageOv = NGroundOverlay(
              //     id: "test",
              //     image: NOverlayImage.fromAssetImage('assets/img/carMarkerImg.png'),
              //     bounds: NLatLngBounds(southWest: NLatLng(36.3552978000, 127.4186789000), northEast: NLatLng(36.3552978000, 127.4186789000))
              // );


              controller.addOverlayAll({marker});

              final onMarkerInfoWindow =
              NInfoWindow.onMarker(id: marker.info.id, text: "기먼우");
              marker.openInfoWindow(onMarkerInfoWindow);

              controller.getContentBounds(withPadding: true);
              controller.getContentRegion(withPadding: true);

              print(controller.getCameraPosition());
            },
            onCameraChange: (NCameraUpdateReason reason, bool animated) {
              print(':::: onCameraChange');
              print(controller?.getCameraPosition());

            },
            onCameraIdle: () {

            },
          ),
        )
    );
  }
}
