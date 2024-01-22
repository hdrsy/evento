import 'package:dartz/dartz.dart';
import '../../../../../core/server/helper_api.dart';
import '../../../../../core/server/server_config.dart';
import '../../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyForgetPasswordController extends GetxController {
  late TextEditingController pin;
  late String phone;
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    pin = TextEditingController();
    phone = Get.arguments;
    formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    getOtp();
    super.onInit();
  }

  getOtp() async {
    Either<ErrorResponse, Map<String, dynamic>> response;

    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.sendCode,
        method: "Post",
        data: {"phone_number": phone});
    print("object");
    dynamic handlingResponse = response.fold((l) => l, (r) => r);

    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
      print(errorMessage[0]);
      Get.snackbar(errorMessage[0], "",
          // duration: Duration(minutes: 1),
          snackPosition: SnackPosition.TOP,
          colorText: customColors.primaryText,
          backgroundColor: customColors.primaryBackground);
    } else {
      print(handlingResponse);
      pin.text = handlingResponse['code'].toString();
      update();
      Get.snackbar(handlingResponse['code'].toString(), "",
          // duration: Duration(minutes: 1),
          snackPosition: SnackPosition.TOP,
          backgroundColor: customColors.primaryBackground);
    }
  }

  onPressContinue() async {
    
    FormState? formdata = formstate.currentState;
    print(formdata!.validate());
    if (formdata!.validate()) {
      formdata.save();
      isLoading.value = true;

      Either<ErrorResponse, Map<String, dynamic>> response;

      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.checkCode,
          method: "Post",
          data: {"code": pin.text, "phone_number": phone});
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      print(pin.text);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        whenvalidateSuccess(handlingResponse);
      }
    }

    isLoading.value = false;
  }

  whenvalidateSuccess(handlingResponse) {
    Get.toNamed('/SetNewPasswordScreen',arguments: [phone,pin.text]);
  }

}
