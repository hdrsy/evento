import 'dart:convert';
import 'dart:developer';

import 'package:evento/core/server/server_config.dart';
import 'package:evento/main.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class SSEService{

static void connectToSSE()async {
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

  var url = Uri.parse('${ServerConstApis.baseAPI}/api/notifications/$userId');
  http.Request request = http.Request("GET", url);
  request.headers["Cache-Control"] = "no-cache";
  request.headers["Accept"] = "text/event-stream";
request.headers['Authorization'] = 'Bearer $token';
  // Send the request
  print("start");
  http.Client().send(request).then((response) {
    // Listen to the stream
    print("response in sse :$response");
    log("message");
    response.stream
        .transform(utf8.decoder) // Decode bytes to UTF8.
        .transform(LineSplitter()) // Convert stream to individual lines.
        .listen((line) {
          print("line $line");
      // Process the line (assuming JSON data)
      if (line.isNotEmpty) {
        // var data = json.decode(line);
        // Handle the data (e.g., show notification)
      }
    }, onDone: () {
      print("done");
      // Connection closed
    }, onError: (error) {
      print("error :$error");
      // Handle errors
    });
  });
}

}