import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/screen/locator_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'home',
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => LocatorScreen(),),
                );
              },
              child: Text('backgroundLocator2'),
            ),
          ],
        )
    );
  }
}
