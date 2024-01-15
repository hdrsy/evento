
import 'dart:convert';
import 'dart:developer';

import 'package:evento/core/utils/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherServiceTR {
  static final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  static Future<void> initPusher() async {
    try {
      await pusher.init(
        apiKey: '3f325939858a7eb5c2f4',
        cluster: 'ap2',
      );
      await pusher.subscribe(
        channelName: "notification1",
        onEvent: (event) {
          var data = json.decode(event.data);
          print(data);
      NotificationService().showNotification(data['title'], data['description']);

        },
      );
      await pusher.connect();
      print("Pusher initializedand connected");
} catch (e) {
print("Error initializing Pusher: $e");
}
}
static void onStart() {
WidgetsFlutterBinding.ensureInitialized();
var service = FlutterBackgroundService();


service.on('RECONNECT_PUSHER').listen((event) {
     pusher.connect();
  
});

ServiceInstance s=ServiceInstance as ServiceInstance;
if(s is AndroidServiceInstance){

s.setAsForegroundService();
}
initPusher();
}

static void start() {
var service = FlutterBackgroundService();
service.startService();
}


}
