import 'dart:developer';
import 'dart:ui';
import 'package:evento/core/utils/services/sse_serive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  
  // Configuring the background service.
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
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
    SSEService.connectToSSE();
  log("stat serr");
  //   if(service is AndroidServiceInstance){
  //     service.setAsBackgroundService();
  //     // if(user==null){
  //     // print("user object in back ground:$user");
  //     //   service.stopSelf();
  //     //   print("the service stopped no user exist");
  //     // }
  //      service.on('stopService').listen((event) {
  //       print ("stop service :$event");
  //   service.stopSelf();
  // });
  // // service.setAsBackgroundService();
  // // if(await service .isForegroundService()){ 
  // //   print("inside set as background");
  // //   SSEService.connectToSSE();

  // // }
  //   }
    
   
}



