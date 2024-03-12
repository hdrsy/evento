import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

void showBatteryOptimizationDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text("requestTitle").tr(),
      content: const Text("requestBody").tr(),
      actions: <Widget>[
        TextButton(
          child: const Text("OK, Let's Do It").tr(),
          onPressed: () {
            Get.back(); // Close the dialog
            requestBatteryOptimization(); // Proceed to request optimization setting
          },
        ),
        TextButton(
          child: const Text("Later").tr(),
          onPressed: () {
            Get.back(); // Optionally, handle refusal or show this option silently
          },
        ),
      ],
    ),
    barrierDismissible: false, // Ensures user makes a choice
  );
}

void requestBatteryOptimization() {
  Pushy.launchBatteryOptimizationsActivity();
}
