import 'package:get/get.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

Future<String> pushyRegister() async {
  try {
    Pushy.setAppId('65eed18265c1588976608a51');
    // Register the user for push notifications
    String deviceToken = await Pushy.register();
    return deviceToken;
    // Display an alert with the device token

    // Optionally send the token to your backend server via an HTTP GET request
    // ...
  } catch (error) {
    // Display an alert with the error message
    print("the error:$error");
    return '';
  }
}
// Please place this code in main.dart,
// After the import statements, and outside any Widget class (top-level)

@pragma('vm:entry-point')
void backgroundNotificationListener(Map<String, dynamic> data) {
  // Print notification payload data
  print('Received notification: $data');

  // Notification title
  String notificationTitle = data['title'];

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText = data['body'] ?? 'Hello World!';

  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);

  // Clear iOS app badge number
  Pushy.clearBadge();
}

@pragma('vm:entry-point')
void notificationClickListener(Map<String, dynamic> data) {
  // Handle notification click
  print("Notification clicked: $data");

  // Normalize title for comparison
  String normalizedTitle = data['title']?.trim().toLowerCase() ?? '';
  String routName = '';
  String body = '';

  // Compare normalized title
  if (normalizedTitle == "new friend request" ||
      normalizedTitle == "new friend") {
    routName =
        'FreindsScreen'; // Note: Check if 'FreindsScreen' is a typo. It should be 'FriendsScreen'?
  } else if (normalizedTitle == "you have a new event invitation") {
    routName =
        'eventDetailes'; // Note: Check spelling, should it be 'eventDetails'?
    body = data['body'];
  } else if (normalizedTitle == "booked successfully") {
    routName = 'MyBookingScreen';
  } else {
    routName = 'NotificationScreen';
  }

  // Check if GetX navigation context is ready, otherwise, delay the navigation
  if (Get.context != null) {
    routName == 'eventDetailes' // Note: Same as above, check spelling.
        ? Get.toNamed('/$routName',
            arguments: [int.parse(body[body.length - 1]), false, 0])
        : Get.toNamed('/$routName');
  } else {
    // Use Future.delayed to wait for GetX navigation context to be ready
    Future.delayed(Duration(seconds: 4), () {
      routName == 'eventDetailes' // Note: Same spelling concern.
          ? Get.toNamed('/$routName',
              arguments: [body[body.length - 1], false, 0])
          : Get.toNamed('/$routName');
    });
  }
}
