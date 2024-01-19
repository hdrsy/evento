import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

checkInternet() async {
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