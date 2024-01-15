import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings("@mipmap/ic_launcher");

    // // iOS Initialization
    // const DarwinInitializationSettings initializationSettingsIOS =
    //     DarwinInitializationSettings(
    //         requestAlertPermission: true,
    //         requestBadgePermission: true,
    //         requestSoundPermission: true);

    // // General Initialization
    // const InitializationSettings initializationSettings =
    //     InitializationSettings(
    //         android: initializationSettingsAndroid,
    //         iOS: initializationSettingsIOS);

    // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    
  // Setting up the notification channel for foreground service.
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground',
    'MY FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initializing the local notifications plugin.
  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  // Creating the notification channel.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('booking', 'booking',
            channelDescription: 'your_channel_description',
            importance: Importance.max,
            priority: Priority.high,
            ongoing: true,
            showWhen: false);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin
        .show(888, title, body, platformChannelSpecifics, );
  }
}