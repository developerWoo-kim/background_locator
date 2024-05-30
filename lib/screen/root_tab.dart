import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/modal/draggable_modal_bottom_sheet.dart';
import 'package:background_locator/common/text/body_text.dart';
import 'package:background_locator/common/util/app_bar_util.dart';
import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/screen/map_and_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>  with TickerProviderStateMixin {
  late ScrollController scrollController = ScrollController();
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);

    controller.addListener(tabListener);
    super.initState();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  AppBar? _buildAppBar() {
    switch (index) {
      case 1:
        return null;
      default:
        return AppBarUtil.buildAppBar(AppBarType.TEXT_TITLE, title: '탭 IN 탭 테스트');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: _buildAppBar(),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), // 탭바에서 스크롤해도 옆으로 안넘어가는 설정
        controller: controller,
        children: [
          Center(child: MapAndListTab(),),
          Stack(
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
                    print('=============');
                  },
                ),
              ),
              DraggableModalBottomSheet(
                  context: context,
                  scrollController: scrollController,
                  content: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BodyText(
                                  title: '목적지를 입력해주세요!',
                                  textSize: BodyTextSize.MEDIUM,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
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
          Center(child: Text('3'),),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed, // 디폴트 : shifting -> 탭 메뉴를 클릭할 때 마다 선택된 메뉴가 확대됨
        onTap: (int index){
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: '00',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: '00',
          ),
        ],
      ),
    );
  }
}
