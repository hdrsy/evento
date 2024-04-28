import 'dart:ui';

import 'package:evento/core/shared/functions/fix_notification_title.dart';
import 'package:evento/main.dart';
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
    return '';
  }
}
// Please place this code in main.dart,
// After the import statements, and outside any Widget class (top-level)

@pragma('vm:entry-point')
void backgroundNotificationListener(Map<String, dynamic> data) async {
  // Notification title
  String notificationTitle = removeNavigateToEnd(
      Get.locale == Locale("en") ? data['title'] : data['title_ar']);

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText = Get.locale == Locale("en")
      ? data['body']
      : data['body_ar'] ?? 'Hello World!';
  // print("notification :$data");
  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);
  isThereNotification.value = true;
  // Clear iOS app badge number
  Pushy.clearBadge();
}

@pragma('vm:entry-point')
void notificationClickListener(Map<String, dynamic> data) {
  // Handle notification click
  // Normalize title for comparison
  // print("notification click :$data");
  String normalizedTitle = data['navigate'] != null
      ? "navigate " + data['navigate']
      : data['title']?.trim().toLowerCase() ?? '';
  print("sssssssssssssssssss $data");
  String routName = '';
  String body = '';
  if (normalizedTitle.contains("navigate")) {
    String targetRout = extractWordAfterNavigate(normalizedTitle);
    if (targetRout.toLowerCase() == "organizer") {
      Get.context != null
          ? Get.toNamed('/OrganizerProfileScreen', arguments: [
              extractNumberAfterWord(normalizedTitle, "organizer"),
              0
            ])
          : Future.delayed(Duration(seconds: 2), () {
              Get.toNamed('/OrganizerProfileScreen', arguments: [
                extractNumberAfterWord(normalizedTitle, "organizer"),
                0
              ]);
            });
    } else if (targetRout.toLowerCase() == "venue") {
      Get.context != null
          ? Get.toNamed('/VenueDetailesForUserScreen',
              arguments: extractNumberAfterWord(normalizedTitle, "venue"))
          : Future.delayed(Duration(seconds: 2), () {
              Get.toNamed('/VenueDetailesForUserScreen',
                  arguments: extractNumberAfterWord(normalizedTitle, "venue"));
            });
    } else if (targetRout.toLowerCase() == "event") {
      print(
          "sssssssssssssssssss ${int.tryParse(normalizedTitle[normalizedTitle.length - 1]).toString()} ");
      int j = extractNumberAfterWord(normalizedTitle, "event");
      print("sssssssssss ${j}");
      Get.context != null
          ? Get.toNamed('/eventDetailes', parameters: {
              'id': extractNumberAfterWord(normalizedTitle, "event").toString(),
              'isOffer': false.toString(),
              'offerPercent': 0.toString(),
            })
          : Future.delayed(Duration(seconds: 2), () {
              Get.toNamed('/eventDetailes', parameters: {
                'id':
                    extractNumberAfterWord(normalizedTitle, "event").toString(),
                'isOffer': false.toString(),
                'offerPercent': 0.toString(),
              });
            });
    }
  } else {
    // Compare normalized title
    if (normalizedTitle == "new friend request" ||
        normalizedTitle == "new friend") {
      routName =
          'FreindsScreen'; // Note: Check if 'FreindsScreen' is a typo. It should be 'FriendsScreen'?
    } else if (normalizedTitle == "you have a new event invitation") {
      routName =
          'eventDetailes'; // Note: Check spelling, should it be 'eventDetails'?
      body = data['body'];
    } else if (normalizedTitle == "booked successfully" ||
        normalizedTitle == "ticket resell") {
      routName = 'MyBookingScreen';
    } else {
      routName = 'NotificationScreen';
    }
  }

  if (!normalizedTitle.contains("navigate")) {
    if (Get.context != null) {
      routName == 'eventDetailes' // Note: Same as above, check spelling.
          ? Get.toNamed('/$routName', parameters: {
              'id': int.tryParse(normalizedTitle[normalizedTitle.length - 1])
                  .toString(),
              'isOffer': false.toString(),
              'offerPercent': 0.toString(),
            })
          : normalizedTitle == "new friend request"
              ? Get.toNamed('/$routName', arguments: 1)
              : Get.toNamed('/$routName');
    } else {
      // Use Future.delayed to wait for GetX navigation context to be ready
      Future.delayed(Duration(seconds: 2), () {
        routName == 'eventDetailes' // Note: Same spelling concern.
            ? Get.toNamed('/$routName', parameters: {
                'id': int.tryParse(normalizedTitle[normalizedTitle.length - 1])
                    .toString(),
                'isOffer': false.toString(),
                'offerPercent': 0.toString(),
              })
            : normalizedTitle == "new friend request"
                ? Get.toNamed('/$routName', arguments: 1)
                : Get.toNamed('/$routName');
      });
    }
  }

  // Check if GetX navigation context is ready, otherwise, delay the navigation
}

int extractNumberAfterWord(String text, String word) {
  final RegExp regex = RegExp(r'\b' + RegExp.escape(word) + r' (\d+)');
  final match = regex.firstMatch(text);
  if (match != null && match.groupCount >= 1) {
    return int.parse(match
        .group(1)!); // Using ! as group(1) will not be null if a match is found
  }
  return 0; // Return null if no matching number is found
}
