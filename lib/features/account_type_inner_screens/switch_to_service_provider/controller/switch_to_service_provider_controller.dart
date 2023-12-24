import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwithcToServiceProviderController extends GetxController{
  late PageController pageController;
  @override
  void onInit() {
    pageController=PageController(initialPage: 0);
    super.onInit();
  }
}