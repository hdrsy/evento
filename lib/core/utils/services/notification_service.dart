import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

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
    await Permission.notification.request();
    // Setting up the notification channel for Android foreground service.
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'booking', // id
      'Booking Notifications', // title
      description: 'This channel is used for important booking notifications.',
      importance: Importance.max,
      playSound: true,
    );

    // Requesting permissions for iOS.
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    // Initializing the local notifications plugin with platform-specific settings.
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(
          '@mipmap/launcher_icon'), // Ensure 'launcher_icon' exists in drawable resources.
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: selectNotification,
    );

    // Creating the notification channel for Android.
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  Future selectNotification(NotificationResponse mm) async {
    // Handle notification tapped logic here
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle iOS foreground notification
  }

  Future<void> showNotification(
      int notificationId, String title, String body) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'booking', // id
      'Booking Notifications', // title
      channelDescription:
          'This channel is used for important booking notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: false,
      playSound: true,
      showWhen: false,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
