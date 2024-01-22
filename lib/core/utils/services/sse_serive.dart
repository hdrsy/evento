import 'dart:convert';
import 'dart:developer';

import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/services/notification_service.dart';
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
                    .showNotification(data['title'], data['description']);
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
static Map<String, String> parseNotification(String message) {
  // First, remove any leading identifiers like "data:"
  String cleanedMessage = message.replaceFirst(RegExp(r'^data: '), '');

  // Remove leading and trailing quotation marks and unnecessary escape characters
  cleanedMessage = cleanedMessage.replaceAll(RegExp(r'\\'), '');
  cleanedMessage = cleanedMessage.replaceAll(RegExp(r'^"|"$'), '');

  // Split the message at each forward slash
  List<String> parts = cleanedMessage.split('/');

  // Check if we have at least two parts to form a title and a body
  if (parts.length >= 2) {
    String title = parts[0].trim();
    // The body is everything after the title, but before the second slash
    String body = parts[1].trim();

    return {
      'title': title,
      'body': body,
    };
  } else {
    // Handle the case where the message format is not as expected
    return {
      'title': 'Unknown',
      'body': 'Message format is incorrect',
    };
  }
}


}