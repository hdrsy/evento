import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../../core/server/helper_api.dart';
import '../../../core/server/server_config.dart';
import '../../../core/shared/controllers/pagination_controller.dart';
import '../../../core/utils/error_handling/erroe_handling.dart';
import '../model/reels_model.dart';
import '../../../main.dart';

class ReelsController extends PaginationController<ReelModel> {
  ReelsController() : super(fetchDataCallback: _fetchData,cacheKey: "ReelsController");
  late int currentUserIndex; // Index of the current user
  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ?? "";
    String apiUrl = "${isGuset?ServerConstApis.getReelsforGuest:ServerConstApis.getReels}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    
    List<dynamic> categoryListJson = handlingResponse['reels']['data'];
    print(categoryListJson);
    lastPageId = handlingResponse['reels']['last_page'];

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
