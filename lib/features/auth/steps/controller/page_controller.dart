// ignore_for_file: avoid_print

import 'package:evento/features/auth/step1/controller/step1_controller.dart';
import 'package:get/get.dart';

class StepsPageController extends GetxController{
  late RxInt pageIdex=1.obs;
  late String phone;
  @override
  void onInit() {
    final arguments=Get.arguments;
    pageIdex.value=arguments[0]??1;
  phone=arguments[1]??"";
  isStep1();
    super.onInit();
  }

  isStep1(){
      pageIdex.value ==1?
      Get.lazyPut(() => Step1Controller(phone: phone)):
      print("not step 1");
      
  }
} 