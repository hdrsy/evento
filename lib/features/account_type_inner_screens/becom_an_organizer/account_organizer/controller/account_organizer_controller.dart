import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountOrganizerController extends GetxController{
 late PageController pageController;
  @override
  void onInit() {
    pageController=PageController(initialPage: 0);
    super.onInit();
  } 
}