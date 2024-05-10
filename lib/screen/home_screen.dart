import 'package:background_locator/common/util/app_bar_util.dart';
import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/screen/locator_screen.dart';
import 'package:background_locator/screen/naver_map_screen.dart';
import 'package:background_locator/screen/root_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        appBar: AppBarUtil.buildAppBar(AppBarType.TEXT_TITLE, title: '홈'),
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => RootTab(),),
                );
              },
              child: Text('RootTab'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => LocatorScreen(),),
                );
              },
              child: Text('backgroundLocator2'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => NaverMapScreen(),),
                );
              },
              child: Text('Naver Map'),
            ),
          ],
        )
    );
  }
}
