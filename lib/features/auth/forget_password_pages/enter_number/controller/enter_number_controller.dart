import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterNumberController extends GetxController{
   late TextEditingController phone;
  late GlobalKey<FormState> formstate;
  late RxBool isLoading;
  late RxList<String> errorMessage;
 
@override
  void onInit() {
    phone=TextEditingController();
     formstate = GlobalKey<FormState>();
    isLoading = false.obs;
    errorMessage=<String>[].obs;
    
    super.onInit();
  }
  onPressContinue()async{
FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      Get.toNamed('/VerifyForgetPasswordScreen',arguments: phone.text);
    }

    isLoading.value = false;
  
  }
 
}