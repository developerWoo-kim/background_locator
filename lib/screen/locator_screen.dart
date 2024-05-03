import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/layout/default_layout.dart';
import 'package:background_locator/util/background_locator2/custom_location_callback_handler.dart';
import 'package:background_locator/util/background_locator2/custom_location_service_repository.dart';
import 'package:background_locator/util/file_manager.dart';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocatorScreen extends StatefulWidget {
  const LocatorScreen({super.key});

  @override
  State<LocatorScreen> createState() => _LocatorScreenState();
}

class _LocatorScreenState extends State<LocatorScreen> {

  ReceivePort port = ReceivePort();

  String logStr = '';
  bool? isRunning;
  LocationDto? lastLocation;

  @override
  void initState() {
    super.initState();

    if (IsolateNameServer.lookupPortByName(
        CustomLocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          CustomLocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, CustomLocationServiceRepository.isolateName);

    port.listen(
          (dynamic data) async {
        await updateUI(data);
      },
    );
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateUI(dynamic data) async {
    final log = await FileManager.readLogFile();

    LocationDto? locationDto = (data != null) ? LocationDto.fromJson(data) : null;
    await _updateNotificationText(locationDto);

    setState(() {
      if (data != null) {
        lastLocation = locationDto;
      }
      logStr = log;
    });
  }

  Future<void> _updateNotificationText(LocationDto? data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "new location received",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    logStr = await FileManager.readLogFile();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
    print('Running ${isRunning.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final start = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Start'),
        onPressed: () {
          _onStart();
        },
      ),
    );
    final stop = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Stop'),
        onPressed: () {
          onStop();
        },
      ),
    );
    final clear = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Clear Log'),
        onPressed: () {
          FileManager.clearLogFile();
          setState(() {
            logStr = '';
          });
        },
      ),
    );
    String msgStatus = "-";
    if (isRunning != null) {
      if (isRunning!) {
        msgStatus = 'Is running';
      } else {
        msgStatus = 'Is not running';
      }
    }
    final status = Text("Status: $msgStatus");

    final log = Text(
      logStr,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter background Locator'),
        ),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[start, stop, clear, status, log],
            ),
          ),
        ),
      ),
    );
  }

  void onStop() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
  }

  void _onStart() async {
    if (await _checkLocationPermission()) {
      await _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();

      setState(() {
        isRunning = _isRunning;
        lastLocation = null;
      });
    } else {
      // show error
    }
  }

  Future<bool> _checkLocationPermission() async {
    final access = await Permission.location.status;
    debugPrint('Access ::: ${access.name}');
    switch (access) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        var result = await Permission.locationWhenInUse.request();
        debugPrint('Result ::: ${result.name}');
        return true;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        return false;
      case PermissionStatus.granted:
        var result = await Permission.locationWhenInUse.request();
        debugPrint('Result ::: ${result.name}');
        return true;
      default:
        return false;
    }
  }

  // Future<bool> _checkLocationPermission() async {
  //   final access = await LocationPermissions().checkPermissionStatus();
  //   print(access);
  //   switch (access) {
  //     case PermissionStatus.unknown:
  //     case PermissionStatus.denied:
  //     case PermissionStatus.restricted:
  //       print(">>>>");
  //       final permission = await LocationPermissions().requestPermissions(
  //         permissionLevel: LocationPermissionLevel.locationAlways,
  //       );
  //       if (permission == PermissionStatus.granted) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //       break;
  //     case PermissionStatus.granted:
  //       return true;
  //       break;
  //     default:
  //       return false;
  //       break;
  //   }
  // }

  Future<void> _startLocator() async{
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
        CustomLocationCallbackHandler.callback,
        initCallback: CustomLocationCallbackHandler.initCallback,
        initDataCallback: data,
        disposeCallback: CustomLocationCallbackHandler.disposeCallback,
        iosSettings: IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            distanceFilter: 0,
            stopWithTerminate: true
        ),
        autoStop: false,
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                CustomLocationCallbackHandler.notificationCallback)));
  }
}
