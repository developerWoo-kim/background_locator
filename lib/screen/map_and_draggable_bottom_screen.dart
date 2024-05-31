import 'package:background_locator/common/component/button/enum/round_degree.dart';
import 'package:background_locator/common/component/button/primary_elevated_button.dart';
import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/modal/draggable_modal_bottom_sheet.dart';
import 'package:background_locator/common/text/body_text.dart';
import 'package:background_locator/common/text/icon_and_text.dart';
import 'package:background_locator/common/util/app_bar_util.dart';
import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/model/on_camera_state_model.dart';
import 'package:background_locator/provider/on_camera_change_provider.dart';
import 'package:background_locator/screen/search_map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';

class MapAndDraggableBottomScreen extends ConsumerStatefulWidget {
  const MapAndDraggableBottomScreen({super.key});

  @override
  ConsumerState<MapAndDraggableBottomScreen> createState() => _MapAndDraggableBottomScreenState();
}

class _MapAndDraggableBottomScreenState extends ConsumerState<MapAndDraggableBottomScreen> with TickerProviderStateMixin {
  late GifController gifController;
  NaverMapController? mapController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    gifController = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBarUtil.buildAppBar(AppBarType.NONE),
      body: Stack(
        children: [
          FractionallySizedBox(
            heightFactor: 0.62,
            child: Stack(
              children: [
                NaverMap(
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
                  onCameraChange: (NCameraUpdateReason reason, bool animated) {
                    ref.read(onCameraChangeProvider.notifier).move();
                  },
                  onCameraIdle: () {
                    ref.read(onCameraChangeProvider.notifier).stop();
                  },
                ),
                _buildCamaraMarker()
              ],
            ),
          ),
          DraggableScrollableSheet(
            // 화면 비율로 높이 조정
            snap: true,
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: _buildBoxDecoration(color: BODY_COLOR_02),
                child: Column(
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
                                                      MaterialPageRoute(builder: (_) => const SearchMapScreen(),),
                                                    ).then((value) {
                                                      if(value != null && value != '') {
                                                        print(value['lat']);
                                                        print(value['lot']);

                                                        mapController?.updateCamera(NCameraUpdate.fromCameraPosition(
                                                            NCameraPosition(
                                                                target: NLatLng(value['lat'], value['lot']),
                                                                zoom: 15)
                                                        ));

                                                      }

                                                      ref.read(onCameraChangeProvider.notifier).action();

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
              );
            },
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

  Widget _buildCamaraMarker() {
    final state = ref.watch(onCameraChangeProvider);

    if(state is OnCameraStateActionModel) {

      return Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(state.state ? 'asset/img/pin_drop_stan_by.png' : 'asset/img/pin_drop.gif',
            width: 60,
            height: 60,
          ),
          // child: Container(
          //   color: state.state ? Colors.red : Colors.black,
          //   width: 20,
          //   height: 20,
          // ),
        ),
      );
    }

    return Container();
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
