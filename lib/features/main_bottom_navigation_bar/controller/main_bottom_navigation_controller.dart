import 'dart:developer';

import 'package:evento/features/customize_event/type_to_set_event/view/type_to_set_event_controller.dart';
import 'package:evento/features/events/home/view/home_screen.dart';
import 'package:evento/features/profile/view/profile_screen.dart';
import 'package:evento/features/reels/controller/video_controller.dart';
import 'package:evento/features/reels/view/reels_screen.dart';
import 'package:evento/features/search/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavigationController extends GetxController {
  late List<Widget> screens;
  @override
  void onInit() {
    screens = [
      HomeScreen(),
      const SearchScreen(),
      ReelsScreen(),
      const TypeToSetEventScreen(),
      const ProfileScreen()
    ];
   
    super.onInit();
  }

  RxInt selectedPage = 0.obs;
  changePage(int index) {
    //// check if i navigate away from reels page pause the video controller for playing in the background
    // if (selectedPage.value == 2) {
    //   var videoController = Get.find<VideoController>();

    //   // Check if the player controller is initialized and playing, then pause
    //   if (videoController.playerController != null &&
    //       videoController.playerController!.value.isPlaying) {
    //     videoController.playerController!.pause();
    //   }
    //   log("video paused");
    // }
    // if (index == 2) {
      
      // var videoController = Get.find<VideoController>();
      // if (videoController.playerController != null &&
      //     !videoController.playerController!.value.isPlaying) {
      //   videoController.playerController!.play();
      // }
      // log("video played");
    // }
    selectedPage.value = index;
  }
}
