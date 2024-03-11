import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/services/pushy.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/services/user_info.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  late TextEditingController phone;
  late TextEditingController password;
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    phone = TextEditingController();
    password = TextEditingController();
    formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    super.onInit();
  }

  onClickSignIn() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String deviceToken = await pushyRegister();

      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.signIn,
          method: "Post",
          data: {
            "phone_number": phone.text,
            "password": password.text,
            "device_token": deviceToken
          });
      dynamic handlingResponse = response.fold((l) => l, (r) => r);

      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        for (var i = 0; i < errorMessage.length; i++) {
          if (errorMessage[i] == "please complete your data") {
            Get.toNamed('/steps', arguments: [1, phone.text]);
          }
        }
      } else {
        whenSignInSuccess(handlingResponse);
      }
    }

    isLoading.value = false;
  }

  whenSignInSuccess(handlingResponse) async {
    String token = handlingResponse['token'];
    prefService.createString("token", token);
    prefService.createString("isCompleteProfile", "true");
    isGuset = false;
    targetRout == '/home';

    user = await UserInfo.getUserInfo();

    Get.offAllNamed('/home');
  }
}
