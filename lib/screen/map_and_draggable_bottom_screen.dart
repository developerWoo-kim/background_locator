import 'package:background_locator/common/modal/draggable_modal_bottom_sheet.dart';
import 'package:background_locator/common/text/body_text.dart';
import 'package:background_locator/common/util/app_bar_util.dart';
import 'package:background_locator/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapAndDraggableBottomScreen extends StatefulWidget {
  const MapAndDraggableBottomScreen({super.key});

  @override
  State<MapAndDraggableBottomScreen> createState() => _MapAndDraggableBottomScreenState();
}

class _MapAndDraggableBottomScreenState extends State<MapAndDraggableBottomScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBarUtil.buildAppBar(AppBarType.TEXT_TITLE, title: '드래그 바텀 시트'),
      body: Stack(
        children: [
          FractionallySizedBox(
            heightFactor: 0.62,
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
                print('=============');
              },
            ),
          ),
          DraggableModalBottomSheet(
            context: context,
            scrollController: scrollController,
            content: BodyText(title: '', textSize: BodyTextSize.MEDIUM, ),
          )
        ],
      ),
    );
  }
}
