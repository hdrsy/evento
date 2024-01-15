// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';

// import 'package:evento/core/utils/services/notification_service.dart';
// // import 'package:evento/core/utils/services/pusher.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'my_foreground',
//     'MY FOREGROUND SERVICE',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.low,
//   );

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initializing the local notifications plugin.
//   if (Platform.isIOS || Platform.isAndroid) {
//     await flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//         iOS: DarwinInitializationSettings(),
//         android: AndroidInitializationSettings('ic_bg_service_small'),
//       ),
//     );
//   }

//   // Creating the notification channel.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);


//  print("init function");

//   // Configuring the background service.
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
//       autoStart: true,
//       isForegroundMode: true,
//       notificationChannelId: 'booking',
//       initialNotificationTitle: 'AWESOME SERVICE',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: 888,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//   );
// }

// // Background fetch handler for iOS.
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   // Additional code if needed
//   return true;
// }

// // Entry point for the service.
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {

//   DartPluginRegistrant.ensureInitialized();
//   final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

//   print("on start function");
//   try {
//     if (service is AndroidServiceInstance) {
// print("inside if");   service.setAsForegroundService();
//     if (await service.isForegroundService() ) {
      
//  await pusher.init(apiKey: '3f325939858a7eb5c2f4', cluster: 'ap2', onConnectionStateChange: (s,k){
//   print("sta:$s");
//   print("sta:$k");
//  });

//     await pusher.subscribe(
//       channelName: "notification1",
      
//       onMemberRemoved: (e){
//         print("333333333333333333");
//         print("$e");
//         print("333333333333333333");
//       },
//       onEvent: (event)async {
//         print("Received event: $event");
//         var data = json.decode(event.data);
//         print("Data: $data");
//         // Handle Pusher event here
//             NotificationService().showNotification(data['title'], data['description']);
//  service.setForegroundNotificationInfo(
//         title: data['title'],
//         content: data['description'],
//       );
//       },
//   );
//     await pusher.connect();
//     print('Subscribed to channel');}}
//   } catch (e) {
//     print("Error initializing Pusher: $e");
//   }
  
   
// }
// Future showNotification(
//     ServiceInstance service, String title, String content) async {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   if (service is AndroidServiceInstance) {
//     if (await service.isForegroundService()) {
//       flutterLocalNotificationsPlugin.show(
//         888,
//         title,
//         content,
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//            'booking', 'booking',
//             icon: 'ic_bg_service_small',
//             ongoing: true,
//           ),
//         ),
//       );

//       service.setForegroundNotificationInfo(
//         title: title,
//         content: content,
//       );
//     }
//   }
// }
