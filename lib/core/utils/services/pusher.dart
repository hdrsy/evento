import 'dart:convert';
import 'package:evento/core/server/server_config.dart';
import '../../../main.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

class PusherService {
  static Future<void> initPusher() async {
    final int? userId = user?.id; // Ensure null safety
    if (userId == null) {
      print("User ID is null");
      return; // Handle null user ID appropriately
    }

    final String? token = await prefService.readString("token");
    if (token == null || token.isEmpty) {
      print("Token is null or empty");
      return; // Handle token not found case appropriately
    }

    try {
      await pusher.init(
        apiKey: '3f325939858a7eb5c2f4',
        cluster: 'ap2',
        
        // useTLS: true,
        // logToConsole: true,
        authEndpoint: "${ServerConstApis.baseAPI}/broadcasting/auth",
        onConnectionStateChange: (state, status) {
          print("Connection state: $state, Status: $status");
          if (status == "DISCONNECTED") {
            pusher.connect();
          }
        },
        onSubscriptionError: (String message, dynamic e) {
          print("Subscription Error: $message, Exception: $e");
        },
        onError: (message, code, error) {
          print("message :$message");
          print("code :$code");
          print("error :$error");
        },
      );

      await pusher.subscribe(
        channelName: "notification$userId",
        
        onEvent: (event) async {
          print("Event received in pusher: $event");
          if (event.data == {}) {
            var data = json.decode(event.data);
            print(data);
            if (data is Map) {
              // NotificationService()
              //     .showNotification(data['title'], data['description']);
            }
          }
        },
        onSubscriptionCount: (n) {
          print("sub:$n");
        },
        onSubscriptionSucceeded: (num) {
          print("num:$num");
        },
        onSubscriptionError: (String message, dynamic e) {
          print("Subscription Error: $message, Exception: $e");
        },
      );

      await pusher.connect();
    } catch (e) {
      print("Initialization Error: $e");
    }
  }
}
