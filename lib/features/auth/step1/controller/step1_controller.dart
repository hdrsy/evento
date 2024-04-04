import 'dart:async';

import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../steps/controller/page_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step1Controller extends GetxController {
  late TextEditingController pin;
  late String phone;
  Step1Controller({required this.phone});
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  RxBool isOtpValid = false.obs;
  RxBool canResendOtp = false.obs;
  Timer? otpTimer = null;
  RxString remainingTime = '10:00'.obs; // Initial value for 10 minutes

  @override
  void onInit() {
    pin = TextEditingController();
    pin.addListener(() {
      isOtpValid.value = pin.text.length == 4;
    });

    formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    getOtp();
    super.onInit();
  }

  void startOtpTimer() {
    canResendOtp.value = false;
    final int startSeconds = 10 * 60; // Initialize once and keep it constant
    int currentSeconds =
        startSeconds; // Current seconds will decrease over time

    // Cancel any previous timer to avoid multiple timers running
    otpTimer?.cancel();

    // Create a new timer
    otpTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (currentSeconds <= 0) {
        timer.cancel();
        canResendOtp.value = true;
        remainingTime.value = '00:00';
      } else {
        // Decrement currentSeconds by 1 for each tick
        currentSeconds -= 1;
        remainingTime.value =
            '${(currentSeconds ~/ 60).toString().padLeft(2, '0')}:${(currentSeconds % 60).toString().padLeft(2, '0')}';
      }
    });
  }

  getOtp() async {
    isOtpValid = false.obs;
    startOtpTimer();

    Either<ErrorResponse, Map<String, dynamic>> response;

    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.sendOtp,
        method: "Post",
        data: {"phone_number": phone});
    dynamic handlingResponse = response.fold((l) => l, (r) => r);

    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {}
  }

  onPressContinue() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      isLoading.value = true;

      Either<ErrorResponse, Map<String, dynamic>> response;

      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.verifyotp,
          method: "Post",
          data: {"otp": pin.text, "phone_number": phone});
      dynamic handlingResponse = response.fold((l) => l, (r) => r);

      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        whenvalidateSuccess(handlingResponse);
      }
    }

    isLoading.value = false;
  }

  whenvalidateSuccess(handlingResponse) {
    String token = handlingResponse['token'];

    prefService.createString("token", token);
    StepsPageController stepsController = Get.find();
    stepsController.pageIdex.value = 2;
  }

  // Ensure to call this in your dispose method to avoid memory leaks
  @override
  void onClose() {
    otpTimer!.cancel();
    super.onClose();
  }
}
