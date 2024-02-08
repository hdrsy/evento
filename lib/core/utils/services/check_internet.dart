import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

checkInternet() async {
  // startTracking();
  // Connectivity().onConnectivityChanged;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // Device is not connected to the internet
    log("Device is not connected to the internet");
    return true;
  } else {
    log("Device is connected to the internet");
    // Device is connected to the internet
    return false;
  }
}

RxBool connectionState = true.obs;

startTracking() {
  // checkInternet();
  print("inside track");
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    print("result.name:${result.name}");
    if (result == ConnectivityResult.none) {
      // Device is not connected to the internet
      log("Device is not connected to the internet in tracking");
      Get.snackbar("Offline", "we are currently offline");
      connectionState.value = false;
    } else {
      log("Device is connected to the internet in tracking");
      // Device is connected to the internet
      connectionState.value = true;
    }

    print("new value is :$connectionState");
  }, onError: (e) {
    print("error $e");
  }, onDone: () {
    print("connection done");
  });
}
