import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/auth/forget_password_pages/verify_forget_password/controller/verify_forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterNumberController extends GetxController {
  late TextEditingController phone;
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;

  @override
  void onInit() {
    phone = TextEditingController();
    formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    errorMessage = <String>[].obs;

    super.onInit();
  }

  getOtp() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      isLoading.value = true;

      Either<ErrorResponse, Map<String, dynamic>> response;

      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.sendCode,
          method: "Post",
          data: {"phone_number": phone.text});

      dynamic handlingResponse = response.fold((l) => l, (r) => r);

      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        final VerifyForgetPasswordController verifyForgetPasswordController =
            Get.put(VerifyForgetPasswordController());
        verifyForgetPasswordController.pin.text =
            handlingResponse['code'].toString();
        verifyForgetPasswordController.phone = phone.text;

        Get.toNamed(
          '/VerifyForgetPasswordScreen',
        );

        update();
      }
      isLoading.value = false;
    }
  }
  // onPressContinue() async {
  //   FormState? formdata = formstate.currentState;
  //   if (formdata!.validate()) {
  //     formdata.save();
  //     Get.toNamed('/VerifyForgetPasswordScreen', arguments: phone.text);
  //   }

  //   isLoading.value = false;
  // }
}
