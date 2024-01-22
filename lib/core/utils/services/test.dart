import 'dart:async';
import 'package:evento/core/utils/services/sse_serive.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

void onStart(ServiceInstance service) async {
  // Set a periodic task
  Timer.periodic(Duration(seconds: 1), (timer) {
    // This will be run in background
   SSEService.connectToSSE();
    // Implement your SSE connection logic here
    // Example: SSEService.connectToSSE();
  });

}
