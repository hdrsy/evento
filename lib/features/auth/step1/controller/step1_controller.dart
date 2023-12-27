import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/auth/steps/controller/page_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step1Controller extends GetxController {
  late TextEditingController pin;
  late String phone;
  Step1Controller({required this.phone});
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    pin = TextEditingController();
    // phone='';
    formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    errorMessage = <String>[].obs;
getOtp();
    super.onInit();
  }

  getOtp() async {
    Either<ErrorResponse, Map<String, dynamic>> response;

    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.sendOtp,
        method: "Post",
        data: {"phone_number": phone});
    dynamic handlingResponse = response.fold((l) => l, (r) => r);

    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      pin.text = extractOtpFromMessage(handlingResponse['message']);
      Get.snackbar(handlingResponse['message'], "",
          // duration: Duration(minutes: 1),
          snackPosition: SnackPosition.TOP,
          backgroundColor: customColors.primaryBackground);
    }
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

  String extractOtpFromMessage(String message) {
    final RegExp otpRegex =
        RegExp(r'\d{4}'); // Regex to find 4 consecutive digits
    final Match? match = otpRegex.firstMatch(message);

    if (match != null) {
      return match.group(0) ?? ""; // Returns the matched OTP
    } else {
      return ""; // No OTP found
    }
  }
}
