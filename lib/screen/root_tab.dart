import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/common/util/app_bar_util.dart';
import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/screen/map_and_list_tab.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>  with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBarUtil.buildAppBar(AppBarType.TEXT_TITLE, title: '탭 IN 탭 테스트'),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), // 탭바에서 스크롤해도 옆으로 안넘어가는 설정
        controller: controller,
        children: [
          Center(child: MapAndListTab(),),
          Center(child: Text('2'),),
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
