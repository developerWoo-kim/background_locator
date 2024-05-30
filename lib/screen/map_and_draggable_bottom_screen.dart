import 'package:background_locator/common/component/button/enum/round_degree.dart';
import 'package:background_locator/common/component/button/primary_elevated_button.dart';
import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/modal/draggable_modal_bottom_sheet.dart';
import 'package:background_locator/common/text/body_text.dart';
import 'package:background_locator/common/text/icon_and_text.dart';
import 'package:background_locator/common/util/app_bar_util.dart';
import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/screen/search_map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapAndDraggableBottomScreen extends StatefulWidget {
  const MapAndDraggableBottomScreen({super.key});

  @override
  State<MapAndDraggableBottomScreen> createState() => _MapAndDraggableBottomScreenState();
}

class _MapAndDraggableBottomScreenState extends State<MapAndDraggableBottomScreen> {
  NaverMapController? mapController;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBarUtil.buildAppBar(AppBarType.NONE),
      body: Stack(
        children: [
          FractionallySizedBox(
            heightFactor: 0.62,
            child: NaverMap(
              options: const NaverMapViewOptions(
                // mapType: NMapType.navi, default = basic
                //   locationButtonEnable: true,
                logoMargin: EdgeInsets.only(left: 20, bottom: 30),
                  initialCameraPosition: NCameraPosition(
                      target: NLatLng(36.33618408, 127.394369),
                      zoom: 15
                  ),
                  minZoom: 6,
                  maxZoom: 16
              ),
              onMapReady: (controller) {
                mapController = controller;
                print('=============');
              },
            ),
          ),
          DraggableModalBottomSheet(
            context: context,
            scrollController: scrollController,
            content: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: _buildBoxDecoration(color: BODY_COLOR_01),
                        child: _buildModalBar(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    color: BODY_COLOR_01,
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                BodyText(
                                                  title: '운행 시작 전 목적지를 입력해주세요!',
                                                  textSize: BodyTextSize.MEDIUM,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.0,),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (_) => SearchMapScreen(),),
                                                ).then((value) async {
                                                  if(value != null && value != '') {
                                                    print(value['lat']);
                                                    print(value['lot']);

                                                    mapController?.updateCamera(NCameraUpdate.fromCameraPosition(
                                                        NCameraPosition(
                                                            target: NLatLng(value['lat'], value['lot']),
                                                            zoom: 15)
                                                    )
                                                    );

                                                    final position = await mapController!.getCameraPosition().then((cp) => cp.target);

                                                    final marker = NMarker(
                                                      id: 'cameraPosition',
                                                      // icon: const NOverlayImage.fromAssetImage('asset/img/carMarkerImg.png'),
                                                      position: NLatLng(position.latitude, position.longitude),
                                                      size: Size(50, 50),
                                                    );

                                                    mapController?.addOverlay(marker);
                                                  }

                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: PRIMARY_COLOR_06,
                                                    borderRadius: BorderRadius.circular(30),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: PRIMARY_COLOR_07.withOpacity(0.2)
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      // Icon(Icons.local_activity),
                                                      BodyText(title: '목적지 입력', color: PRIMARY_COLOR_07, textSize: BodyTextSize.SMALL, fontWeight: FontWeight.w500,),
                                                      Icon(Icons.search_outlined, size: 18, color: PRIMARY_COLOR_07,)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 16.0,),
                                            Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        BodyText(
                                                          title: '자주가는 목적지',
                                                          textSize: BodyTextSize.REGULAR,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        Icon(Icons.settings,
                                                          size: 20,
                                                          color: PRIMARY_COLOR_05,
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        IconAndText(
                                                          iconData: Icons.home_outlined,
                                                          title: '집',
                                                        ),
                                                        SizedBox(width: 25.0,),
                                                        IconAndText(
                                                          iconData: Icons.star_border_outlined,
                                                          title: '물류창고1',
                                                        ),
                                                        SizedBox(width: 25.0,),
                                                        IconAndText(
                                                          iconData: Icons.star_border_outlined,
                                                          title: '물류창고2',
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                            ),
                                          ],
                                        )
                                    )
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    color: BODY_COLOR_01,
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                BodyText(
                                                  title: '진행 중인 광고',
                                                  textSize: BodyTextSize.MEDIUM,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.0,),
                                          ],
                                        )
                                    )
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: PrimaryElevatedButton(
                            title: '운행 시작',
                            roundDegree: RoundDegree.LOW,
                            backgroundColor: PRIMARY_COLOR_05,
                            textColor: PRIMARY_COLOR_04,
                            callback: () {},
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 30,
                height: 30,
                child: Icon(Icons.arrow_back, )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModalBar() {
    return FractionallySizedBox(
      widthFactor: 0.20,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: LINE_CLOR_01,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration({required Color color}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
      ),
    );
  }
}
