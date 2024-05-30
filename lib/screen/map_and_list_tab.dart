import 'package:background_locator/common/component/search_box_style1.dart';
import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/data/dummy_data.dart';
import 'package:background_locator/model/location_model.dart';
import 'package:background_locator/model/map_info_model.dart';
import 'package:background_locator/provider/location_provider.dart';
import 'package:background_locator/provider/map_info_provider.dart';
import 'package:background_locator/screen/map_screen.dart';
import 'package:background_locator/screen/search_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapAndListTab extends ConsumerStatefulWidget {
  const MapAndListTab({super.key});

  @override
  ConsumerState<MapAndListTab> createState() => _MapAndListTabState();
}

class _MapAndListTabState extends ConsumerState<MapAndListTab> with TickerProviderStateMixin {
  late TabController _tabController;
  NaverMapController? mapController;

  NInfoWindow? nInfoWindow;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );

    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SearchMapScreen(),),
              ).then((value) {
                if(value != null && value != '') {
                  print(value['lat']);
                  print(value['lot']);

                  mapController?.updateCamera(NCameraUpdate.fromCameraPosition(
                    NCameraPosition(
                      target: NLatLng(value['lat'], value['lot']),
                      zoom: 15)
                    )
                  );

                }

              });
            },
            child: SearchBoxStyle1(),
          )
        ),
        TabBar(
          tabs: [
            Container(
              height: 45,
              alignment: Alignment.center,
              child: Text(
                '지도보기',
              ),
            ),
            Container(
              height: 45,
              alignment: Alignment.center,
              child: Text(
                '목록보기',
              ),
            ),
          ],
          indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: PRIMARY_COLOR2, width: 3
                ),
              )
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          controller: _tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(), // 탭바에서 스크롤해도 옆으로 안넘어가는 설정
            children: [
              Stack(
                children: [
                  _NaverMap(),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: _MarkerInfoView()
                  )
                ],
              ),

              Container(
                color: Colors.green[200],
                alignment: Alignment.center,
                child: Text(
                  'Tab2 View',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _MarkerInfoView() {
    final state = ref.watch(mapInfoProvider);

    if(state is MapInfoModelEmptyData) {
      return Container(
        child: Text(''),
      );
    }

    final data = state as MapInfoModel;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: BODY_TEXT_COLOR,
                width: 1
            ),
          ),
          height: 100,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                Image.asset(data.image,
                  fit: BoxFit.fill,
                  width: 80,
                  height: 80,
                ),
                SizedBox(width: 6.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title),
                    Text(data.address)
                  ],
                )
              ],
            ),
          )
        )
    );
  }

  Widget _NaverMap() {
    final state = ref.watch(locationProvider);

    if(state is LocationModelLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final location = state as LocationModel;

    return NaverMap(
      options: NaverMapViewOptions(
        mapType: NMapType.basic,
        // locationButtonEnable: true,
        initialCameraPosition: NCameraPosition(
            target: NLatLng(location.latitude, location.longitude),
            zoom: 15
        ),
        minZoom: 6,
        maxZoom: 17,
        extent: NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
      ),
      onMapReady: (controller) {
        mapController = controller;
        print('============= ${DummyData.list.length}');
        for (var model in DummyData.list) {
          if(model.viewLevel == 1) {

            final marker = NMarker(
              id: model.name,
              icon: const NOverlayImage.fromAssetImage('asset/img/mart_icon.png'),
              position: NLatLng(model.lat, model.lot),
              size: const Size(100, 100),
            );

            marker.setOnTapListener((overlay) {
              controller.updateCamera(NCameraUpdate.scrollAndZoomTo(target: overlay.position));
              ref.read(mapInfoProvider.notifier).changeMapInfo(
                  title: model.title,
                  address: model.address,
                  image: model.image
              );
            });


            marker.setMinZoom(14);
            marker.setIsMinZoomInclusive(true);
            marker.setMaxZoom(18);
            marker.setIsMaxZoomInclusive(false);
            controller.addOverlay(marker);

          } else if(model.viewLevel == 2) {

            final circle = NCircleOverlay(
              id: model.name,
              center: NLatLng(model.lat, model.lot),
              color: PRIMARY_COLOR2.withOpacity(0.5),
              radius: 250
            );

            circle.setMinZoom(12);
            circle.setIsMinZoomInclusive(true);
            circle.setMaxZoom(14);
            circle.setIsMaxZoomInclusive(false);
            controller.addOverlay(circle);
          }

        }
        print('=============');
      },
      onCameraChange: (NCameraUpdateReason reason, bool animated) {
        if(reason.payload == -1 && ref.read(mapInfoProvider) is MapInfoModel) {
          ref.read(mapInfoProvider.notifier).clear();
        }
      },
      onCameraIdle: () {
        print('onCameraIdle');
      },
    );
  }
}

