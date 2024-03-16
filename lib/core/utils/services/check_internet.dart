import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:evento/core/shared/controllers/pagination_controller.dart';
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
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      // Device is not connected to the internet
      Get.snackbar("Offline", "we are currently offline");
      connectionState.value = false;
    } else {
      // Device is connected to the internet
      Get.find<PaginationController>().refreshData();
      connectionState.value = true;
    }
  }, onError: (e) {}, onDone: () {});
}
