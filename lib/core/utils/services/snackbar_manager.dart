import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarManager {
  static final RxBool _isSnackbarActive = false.obs;

  static void showSnackbar(String title, String message,
      {SnackPosition position = SnackPosition.BOTTOM,
      Color backgroundColor = Colors.blue,
      Color textColor = Colors.white}) {
    if (_isSnackbarActive.value) {
      // A snackbar is already being shown
      return;
    }
    _isSnackbarActive.value = true;
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      duration: Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );

    // Use a timer to reset _isSnackbarActive after the duration of the snackbar
    Timer(Duration(seconds: 3), () {
      _isSnackbarActive.value = false;
    });
  }
}
