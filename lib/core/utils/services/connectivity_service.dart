import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:evento/core/utils/services/snackbar_manager.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final RxBool isConnected = false.obs;
  bool _firstCheck = true; // Add flag to track the first connectivity check

  Future<ConnectivityService> init() async {
    var initialStatus = await Connectivity().checkConnectivity();
    isConnected.value = initialStatus != ConnectivityResult.none;

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      bool previousState = isConnected.value;
      isConnected.value = result != ConnectivityResult.none;
      if (_firstCheck && result == ConnectivityResult.none) {
        SnackbarManager.showSnackbar(
          "Offline",
          "No internet connection.",
          icon: Icon(Icons.wifi_off_outlined, color: customColors.primaryText),
          backgroundColor: customColors.primaryBackground,
        );
        _firstCheck = false;
      }
      // Only show snackbar if it's not the first check and there was a change
      else if (!_firstCheck && previousState != isConnected.value) {
        if (isConnected.value) {
          SnackbarManager.showSnackbar(
            "Online",
            "You are back online.",
            icon: Icon(Icons.wifi_outlined, color: customColors.primaryText),
            backgroundColor: customColors.primaryBackground,
          );
          // Show "back online" snackbar
        } else {
          SnackbarManager.showSnackbar(
            "Offline",
            "No internet connection.",
            icon:
                Icon(Icons.wifi_off_outlined, color: customColors.primaryText),
            backgroundColor: customColors.primaryBackground,
          );
          // Show "offline" snackbar
        }
      }
      _firstCheck = false; // Update flag after handling first check
    });
    return this;
  }
}
