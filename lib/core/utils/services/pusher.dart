import 'dart:convert';
import 'package:evento/core/server/server_config.dart';
import 'notification_service.dart';
import '../../../main.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;

final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

class PusherService {
  static dynamic onAuthorizer(String channelName, String socketId, dynamic options) async {
    // Ensure that the token is being read correctly and handle null cases
    final String? token = await prefService.readString("token");
    if (token == null || token.isEmpty) {
      print("Token is null or empty");
      return null; // Handle token not found case appropriately
    }
      final int? userId = user?.id; // Ensure null safety
    if (userId == null) {
      print("User ID is null");
      return; // Handle null user ID appropriately
    }

    try {
      final response = await http.post(
        Uri.parse("${ServerConstApis.baseAPI}/broadcasting/auth"),
        headers: {'Authorization': 'Bearer $token'},
        body: {'socket_id': "1738302", 'channel_name': "private-notification$userId"},
      );

print("response :${response.body}");
      if (response.statusCode == 200) {
      final Map<String, dynamic> authData = jsonDecode(response.body);
      if (!authData.containsKey('auth') || !authData.containsKey('shared_secret')) {
        print("Authorization response missing required fields");
        return null;
      }
      return authData;
    } else {
      print("Error in authorization: ${response.body}");
      return null;
    }
    } catch (e) {
      print("Error in onAuthorizer: $e");
      return null;
    }
  }

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
        // onAuthorizer: onAuthorizer,
// authParams: {
//   "headers": {'Authorization': 'Bearer $token'}
// },

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
      );
// pusher.setChannelAuthorizer()

      await pusher.subscribe(
        channelName: "notification$userId",

        onEvent: (event) async {
          print("Event received in pusher: $event");
          if(event.data == {}){

          var data = json.decode(event.data);
          print(data);
          if(data is Map){

          NotificationService().showNotification(data['title'], data['description']);
          }
          }
        },
        onSubscriptionCount: (n){
          print("sub:$n");
        },
        onSubscriptionSucceeded: ( num){
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