import 'dart:convert';
import 'dart:developer';

import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/services/notification_service.dart';
import 'package:evento/core/utils/services/user_info.dart';
import 'package:evento/main.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
class SSEService{

static void connectToSSE()async {
   user = await UserInfo.getUserInfo();
    final int? userId = user?.id; // Ensure null safety
    if (user == null) {
      FlutterBackgroundService service=FlutterBackgroundService();
    service.invoke("stopService");
      return; // Handle null user ID appropriately
    }

    final String? token = await prefService.readString("token");
    if (token == null || token.isEmpty) {
      print("Token is null or empty");
      return; // Handle token not found case appropriately
    }
  //   var status = await Permission.notification.status;
  // if (!status.isGranted) {
  //   // Request permission
  //   await Permission.notification.request();
  // }
 
  var url = Uri.parse('${ServerConstApis.baseAPI}/api/notifications/$userId');
  http.Request request = http.Request("GET", url);
  request.headers["Cache-Control"] = "no-cache";
  request.headers["Accept"] = "text/event-stream";
request.headers['Authorization'] = 'Bearer $token';
  // Send the request
  print("start sse");
  http.Client().send(request).then((response) {
    // Listen to the stream
    print("response in sse :$response");
    log("message");
    response.stream
        .transform(utf8.decoder) // Decode bytes to UTF8.
        .transform(const LineSplitter()) // Convert stream to individual lines.
        .listen((line) {
        print("line $line");
    log(line);

    // Process the line (assuming JSON data)
    if (line.isNotEmpty) {
        // Remove the 'data: ' prefix if it exists
        var jsonLine = line.startsWith('data: ') ? line.substring(6) : line;

        try {
            var data = json.decode(jsonLine);
            print(data);

            if (data is Map) {
              isThereNotification.value=true;
                NotificationService()
                    .showNotification(data['id'],data['title'], data['description']);
            }
        } catch (e) {
            print('Error parsing JSON: $e');
        }}
    }, onDone: () {
      print("done");
      log("done");
      // Connection closed
    }, onError: (error) {
      log("onError");
      print("error :$error");
      // Handle errors
    });
  });
}

}