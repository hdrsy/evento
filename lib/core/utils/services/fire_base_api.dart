import 'package:evento/core/utils/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

final firebaseMessaging = FirebaseMessaging.instance;

class FirebaseApi {
  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print("firebase token is : $fcmToken");
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    await NotificationService().init();
  }
}

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
  Get.toNamed("/");
}

Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  FirebaseMessaging.onMessage.listen((event) {
    final notification = event.notification;
    if (notification == null) return;
    NotificationService().showNotification(
        1, notification.title ?? "empty", notification.body ?? "emptyBody");
  });
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("title ${message.notification!.title}");
  print("Body ${message.notification!.body}");
  print("paylod ${message.data}");
}
