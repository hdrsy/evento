import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController{
  late TextEditingController oldPassword;
  late TextEditingController newPassword;
  late TextEditingController retypePassword;
   late RxList<String> errorMessage;
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
@override
  void onInit() {
    oldPassword=TextEditingController();
    newPassword=TextEditingController();
    retypePassword=TextEditingController();
    isLoading=false.obs;
   formstate = GlobalKey<FormState>();
        errorMessage=<String>[].obs;
    super.onInit();
  }
  onPressDone()async{
    
FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      errorMessage.clear();
     isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.changePassword,
        method: "post",
        token: token,
        data: {
"old_password":oldPassword.text,
"new_password":newPassword.text
        }
        );

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
      
    } else {
      whenGetDataSuccess(handlingResponse);
    }
    isLoading.value = false;}
  }
  whenGetDataSuccess(handlingResponse){
    

    Get.back();

  }
}