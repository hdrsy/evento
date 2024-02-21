import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();
  late RxInt _totalSeconds;
  late RxBool _isRunning;
  late RxInt _hours;
  late RxInt _minutes;
  late RxInt _seconds;
  int get hours => _hours.value;
  int get minutes => _minutes.value;
  int get seconds => _seconds.value;
  bool get isRunning => _isRunning.value;
  Timer? timer;

  @override
  void onInit() {
    _totalSeconds = 60.obs;
    _isRunning = false.obs;
    _hours = 00.obs;
    _minutes = 1.obs;
    _seconds = 00.obs;
    startTimer();
    // TODO: implement onInit
    super.onInit();
  }

  void updateTimerDisplay() {
    _hours.value = _totalSeconds.value ~/ 3600;
    _minutes.value = (_totalSeconds.value ~/ 60) % 60;
    _seconds.value = _totalSeconds.value % 60;
  }

  startTimer() {
    if (!_isRunning.value) {
      _isRunning.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_totalSeconds > 0) {
          _totalSeconds.value--;
          updateTimerDisplay();
        } else {
          timer!.cancel();
        }
      });
    }
  }
}