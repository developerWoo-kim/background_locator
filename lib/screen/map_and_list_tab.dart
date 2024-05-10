import 'package:background_locator/common/component/search_box_style1.dart';
import 'package:background_locator/common/const/colors.dart';
import 'package:background_locator/screen/map_screen.dart';
import 'package:background_locator/screen/search_map_screen.dart';
import 'package:flutter/material.dart';

class MapAndListTab extends StatefulWidget {
  const MapAndListTab({super.key});

  @override
  State<MapAndListTab> createState() => _MapAndListTabState();
}

class _MapAndListTabState extends State<MapAndListTab> with TickerProviderStateMixin {
  late TabController _tabController;

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
                  print(value);
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
              MapScreen(),
              Container(
                color: Colors.green[200],
                alignment: Alignment.center,
                child: Text(
                  'Tab2 View',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
