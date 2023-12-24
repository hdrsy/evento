import 'dart:developer';

import 'package:evento/features/reels/controller/video_controller.dart';
import 'package:evento/features/reels/model/reels_model.dart';
import 'package:evento/features/reels/service/reels_service.dart';
import 'package:get/get.dart';

class ReelsController extends GetxController
{
  
  @override
  void onClose() {
    // Get the existing instance of VideoController
    var videoController = Get.find<VideoController>();

    // Check if the player controller is initialized and playing, then pause
    if (videoController.playerController != null &&
        videoController.playerController!.value.isPlaying) {
      videoController.playerController!.pause();
    }

    // Dispose the video controller
    videoController.dispose();

    log("ReelsController is being disposed");

    super.onClose();
  }

  late List<RR> videoList;
  late int
      currentVideoIndex; // Index of the current video in the current user's video list
  late int currentUserIndex; // Index of the current user

  @override
  void onInit() {

    videoList = getFakeData();
    ReelService().getVideosFromApI();
    currentVideoIndex = 0;
    currentUserIndex = 0;
    // Get.lazyPut<VideoController>(() => VideoController());
    super.onInit();
  }

  VideoDetails getCurrentVideo() {
    return videoList[currentUserIndex].videos[currentVideoIndex];
  }

  String getCurrentVideoUrl() {
    return getCurrentVideo().url;
  }

  void nextVideo() {
    if (currentVideoIndex + 1 < videoList[currentUserIndex].videos.length) {
      currentVideoIndex++;
      update();
      VideoController videoController = Get.find();
      videoController.changeVideo(getCurrentVideoUrl());
    }
  }

  void previousVideo() {
    if (currentVideoIndex > 0) {
      currentVideoIndex--;
      update();
      VideoController videoController = Get.find();
      videoController.changeVideo(getCurrentVideoUrl());
    }
  }

  void nextUser() {
    if (currentUserIndex + 1 < videoList.length) {
      currentUserIndex++;
      currentVideoIndex = 0; // Reset to the first video of the next user
      update();
      VideoController videoController = Get.find();
      videoController.changeVideo(getCurrentVideoUrl());
    }
  }

  void previousUser() {
    if (currentUserIndex > 0) {
      currentUserIndex--;
      currentVideoIndex = 0; // Reset to the first video of the previous user
      update();
      VideoController videoController = Get.find();
      videoController.changeVideo(getCurrentVideoUrl());
    }
  }
}
