import 'dart:developer';
import 'dart:ui';
import 'package:evento/core/utils/services/socket_servie.dart';
import 'package:evento/core/utils/services/user_info.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  // Configuring the background service.
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
      //  foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

// Background fetch handler for iOS.
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  // Additional code if needed
  return true;
}

// Entry point for the service.
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  log("stat serr");
  if (service is AndroidServiceInstance) {
    // if (await service.isForegroundService()) {
    //   service.setAsForegroundService();
    // }
    // if(service.)
    service.on("setAsBackground").listen((event) {
      service.setAsBackgroundService();
      print("the service in backround");
    });

    service.on('stopService').listen((event) {
      print("stop service :$event");
      service.stopSelf();
    });
    service.setForegroundNotificationInfo(title: "test", content: "content");
  }

  user = await UserInfo.getUserInfo();

  listenToEvents(user!.id);
}
