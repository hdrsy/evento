import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/follow_unfollow_event_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/server/helper_api.dart';
import '../../../core/server/server_config.dart';
import '../../../core/shared/controllers/pagination_controller.dart';
import '../../../core/utils/error_handling/erroe_handling.dart';
import '../model/reels_model.dart';
import '../../../main.dart';

class ReelsController extends PaginationController<ReelModel> {
  ReelsController()
      : super(fetchDataCallback: _fetchData, cacheKey: "ReelsController");
  late int currentUserIndex; // Index of the current user
  late PageController innerPageController = PageController();

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ?? "";
    print("page id :$page");
    String apiUrl =
        "${isGuset ? ServerConstApis.getReelsforGuest : ServerConstApis.getReels}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  RxDouble videoProgress = 0.0.obs; // Tracks progress of the current video

  void updateProgress(double progress) {
    videoProgress.value = progress;
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['reels']['data'];
    print(categoryListJson);
    print(
        "reels len : ${categoryListJson.length} , ${handlingResponse['reels']['current_page']}");
    print("reeels response :$handlingResponse");
    lastPageId = handlingResponse['reels']['last_page'];
    print("lastPageId is :$lastPageId");
    itemList.addAll(categoryListJson
        .map((jsonItem) => ReelModel.fromJson(jsonItem))
        .toList());
    currentUserIndex = 0;
    if (pageId == lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  followOrUnFollowreelEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (itemList[modelIndex].event!.isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      itemList[modelIndex].event!.isFollowedByAuthUser = true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      itemList[modelIndex].event!.isFollowedByAuthUser = false;

      update();
    }
  }

  playNextVideo(int userIndex, int videoIndex) {
    if (innerPageController.page!.round() + 1 <
        itemList[userIndex].videos.length) {
      print("inside next video");
      innerPageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    } else if (innerPageController.page!.round() + 1 ==
        itemList[userIndex].videos.length) {
      print("inside next user");
      pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  prevVideoInSameUser(int userIndex, int videoIndex) {
    if (innerPageController.page!.round() + 1 > 1) {
      print("inside next video");
      innerPageController.previousPage(
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (itemList[modelIndex].likedByUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.likeReel}/$eventId/like");
    } else {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.likeReel}/$eventId/like");
    }
    if (isDoneSuccefully == "Like added successfully") {
      itemList[modelIndex].likedByUser = true;
      itemList[modelIndex].likesCount += 1;
      update();
    } else if (isDoneSuccefully == "like deleted successfully") {
      itemList[modelIndex].likedByUser = false;

      itemList[modelIndex].likesCount -= 1;
      update();
    }
  }

  void nextUser() {
    if (currentUserIndex + 1 < itemList.length) {
      currentUserIndex++;
      update();
    }
  }

  void previousUser() {
    if (currentUserIndex > 0) {
      currentUserIndex--;
      update();
    }
  }
}

// class ReelsController extends GetxController
// {
  
//   @override
//   void onClose() {
//     // Get the existing instance of VideoController
//     // var videoController = Get.find<VideoController>();

//     // // Check if the player controller is initialized and playing, then pause
//     // if (videoController.playerController != null &&
//     //     videoController.playerController!.value.isPlaying) {
//     //   videoController.playerController!.pause();
//     // }

//     // // Dispose the video controller
//     // videoController.dispose();

//     log("ReelsController is being disposed");

//     super.onClose();
//   }

//   late List<RR> videoList;
//   late int
//       currentVideoIndex; // Index of the current video in the current user's video list
//   late int currentUserIndex; // Index of the current user

//   @override
//   void onInit() {

//     videoList = getFakeData();
//     ReelService().getVideosFromApI();
//     currentVideoIndex = 0;
//     currentUserIndex = 0;
//     // Get.lazyPut<VideoController>(() => VideoController());
//     super.onInit();
//   }

//   VideoDetails getCurrentVideo() {
//     return videoList[currentUserIndex].videos[currentVideoIndex];
//   }

//   String getCurrentVideoUrl() {
//     return getCurrentVideo().url;
//   }

//   void nextVideo() {
//     if (currentVideoIndex + 1 < videoList[currentUserIndex].videos.length) {
//       currentVideoIndex++;
//       update();
//       // VideoController videoController = Get.find();
//       // videoController.changeVideo(getCurrentVideoUrl());
//     }
//   }

//   void previousVideo() {
//     if (currentVideoIndex > 0) {
//       currentVideoIndex--;
//       update();
//       // VideoController videoController = Get.find();
//       // videoController.changeVideo(getCurrentVideoUrl());
//     }
//   }

//   
//   void previousUser() {
//     if (currentUserIndex > 0) {
//       currentUserIndex--;
//       currentVideoIndex = 0; // Reset to the first video of the previous user
//       update();
//       // VideoController videoController = Get.find();
//       // videoController.changeVideo(getCurrentVideoUrl());
//     }
//   }
// }
