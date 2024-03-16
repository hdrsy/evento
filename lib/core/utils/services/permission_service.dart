import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PermissionService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool> requestNotificationPermission() async {
    if (!await _notificationPermissionGranted()) {
      // For iOS, request permission
      if (await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              ) ??
          false) {
        return true;
      }
      return false;
    }
    return true;
  }

  Future<bool> _notificationPermissionGranted() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  }
}
