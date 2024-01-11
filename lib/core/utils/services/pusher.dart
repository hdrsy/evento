import 'dart:convert';


import 'package:evento/core/utils/services/notification_service.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';


class PusherService {
  static final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
static Future<void> initPusher() async {
  try {
    await pusher.init(apiKey: '3f325939858a7eb5c2f4', cluster: 'ap2', );
    await pusher.subscribe(channelName: "booking2",onEvent: ( event){
      print("Event  $event");
          var data = json.decode(event.data);
          print(data);
      NotificationService().showNotification('Booking succefly', 'This is a test notification');

    },
    
    );
    await pusher.connect();

  } catch (e) {
    print("Error: $e");
  }
}

}
