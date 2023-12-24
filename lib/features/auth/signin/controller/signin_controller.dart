import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController{
  late TextEditingController phone;
  late TextEditingController password;
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;
 @override
  void onInit() {
    phone=TextEditingController();
    password=TextEditingController();
     formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    errorMessage=<String>[].obs;
    super.onInit();
  }
  onClickSignIn()async{
FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      isLoading.value = true;

      Either<ErrorResponse, Map<String, dynamic>> response;

      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.signIn,
          method: "Post",
          data: {
            "phone_number": phone.text,
    "password":password.text
          });
          print(response);
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      
      if (handlingResponse is ErrorResponse) {
        errorMessage.value= handlingResponse.getErrorMessages();
        for (var i = 0; i < errorMessage.length; i++) {
          if(errorMessage[i]=="please complete your data"){
            Get.toNamed('/steps',arguments: [1,phone.text]);
  
          }
        }
      }else{

        whenSignInSuccess(handlingResponse);
      }
    }

    isLoading.value = false;
  
  }
  whenSignInSuccess(handlingResponse){
     String token = handlingResponse['token'];
       print(handlingResponse);
    prefService.createString("token", token);
    Get.offAllNamed('/home');
  }
}