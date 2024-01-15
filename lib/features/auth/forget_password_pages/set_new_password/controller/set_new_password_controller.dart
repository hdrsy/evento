import 'package:dartz/dartz.dart';
import '../../../../../core/server/helper_api.dart';
import '../../../../../core/server/server_config.dart';
import '../../../../../core/utils/error_handling/erroe_handling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetNewPasswordController extends GetxController{
  late TextEditingController newPassword;
  late TextEditingController confPassword;
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;
 late String phone;
 late String pin;
@override
  void onInit() {
    newPassword=TextEditingController();
    confPassword=TextEditingController();
     formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    errorMessage=<String>[].obs;
    phone=Get.arguments[0];
    pin=Get.arguments[1];
    super.onInit();
  }
   onPressContinue() async {
    
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      isLoading.value = true;

      Either<ErrorResponse, Map<String, dynamic>> response;

      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.changePasswordForgetten,
          method: "Post",
          data: {"code": pin, "phone_number": phone,"password":newPassword.text,"password_confimation":confPassword.text});
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
    Get.offAllNamed('/');
  }

} 