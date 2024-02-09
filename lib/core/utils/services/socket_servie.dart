import 'package:evento/core/utils/services/notification_service.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

void listenToEvents(int userId) {
  // Replace these with your actual server details
  final String channelName = 'notification$userId';

  // Initialize the WebSocket connection
  final channel = WebSocketChannel.connect(Uri.parse(
      'ws://94.141.219.13:6001/app/3f325939858a7eb5c2f4?protocol=7&client=js&version=4.3.1&flash=false'));

  // Listen for messages
  channel.stream.listen((message) {
    print("state");
    final decodedMessage = jsonDecode(message);

    // Check if the message is for the channel you're interested in
    if (decodedMessage['channel'] == channelName &&
        decodedMessage['event'] == 'App\\Events\\NotificationEvent') {
      // Handle your event data here
      print('Event Data: ${decodedMessage['data']}');
      var data = json.decode(decodedMessage['data']);

      print((data['title']).toString());

      NotificationService()
          .showNotification(112233, data['title'], data['description']);
    }
  });

  // Subscribe to the channel
  channel.sink.add(jsonEncode({
    'event': 'pusher:subscribe',
    'data': {
      'channel': channelName,
    },
  }));
}
