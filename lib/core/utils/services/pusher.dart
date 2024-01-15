import 'dart:convert';


import 'back_ground_service.dart';
import 'notification_service.dart';
import '../../../main.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';


   final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
class PusherService {
static Future<void> initPusher() async {
// print("user id:${user!.id}");
// int userId=user!.id;

  try {
    await pusher.init(apiKey: '3f325939858a7eb5c2f4', cluster: 'ap2', onConnectionStateChange: (s,k){
  print("sta inpusher:$s");
  print("sta inpusher:$k");
 } );
    await pusher.subscribe(channelName: "notification1",onEvent: ( event)async{
      
        // await initializeService();
      print("Event in pusher  $event");
          var data = json.decode(event.data);
          print(data);
      NotificationService().showNotification(data['title'], data['description']);

    },
    
    );
    await pusher.connect();

  } catch (e) {
    print("Error: $e");
  }
}

}
