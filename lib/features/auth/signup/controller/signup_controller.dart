import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phone;
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  late RxBool isAgreedOn;
  @override
  void onInit() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    phone = TextEditingController();
    formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    isAgreedOn=false.obs;
    // statuseRequest = StatuseRequest.init;
    errorMessage = <String>[].obs;
    super.onInit();
  }

  onPressSignUp() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      isLoading.value = true;

      Either<ErrorResponse, Map<String, dynamic>> response;

      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.signUpStep1,
          method: "Post",
          data: {
            "phone_number": phone.text,
            "first_name": firstName.text,
            "last_name": lastName.text
          });
          
      dynamic handlingResponse = response.fold((l) => l, (r) => r);

      if (handlingResponse is ErrorResponse) {
     
        errorMessage.value = handlingResponse.getErrorMessages();
        for (var i = 0; i < errorMessage.length; i++) {
          if(errorMessage[i]=="please complete your data"){
            Get.toNamed('/steps',arguments: [2,phone.text]);
  
          }
        }
      } else {
        
        whenSignUpSuccess(handlingResponse);
      }
    }
    
    isLoading.value = false;
  }

  whenSignUpSuccess(handlingResponse) {
    
    Get.toNamed('/steps',arguments: [1,phone.text]);
  }
}
