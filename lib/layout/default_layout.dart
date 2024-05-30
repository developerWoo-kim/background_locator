import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}