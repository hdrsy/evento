import 'package:dartz/dartz.dart';
import 'package:evento/core/server/follow_unfollow_event_api.dart';
import 'package:flutter/material.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/shared/controllers/pagination_controller.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/reels_model.dart';
import '../../../../main.dart';

class ReelsController extends PaginationController<ReelModel> {
  ReelsController()
      : super(fetchDataCallback: _fetchData, cacheKey: "ReelsController");
  late int currentUserIndex; // Index of the current user
  late PageController innerPageController = PageController();

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl =
        "${isGuset ? ServerConstApis.getReelsforGuest : ServerConstApis.getReels}?page=$page";

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
    lastPageId = handlingResponse['reels']['last_page'];
    itemList.addAll(categoryListJson
        .map((jsonItem) => ReelModel.fromJson(jsonItem))
        .toList());
    itemList.any((element) {
      return true;
    });
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

  Future<void> refreshScreen() async {
    await refreshData();
  }

  playNextVideo(int userIndex, int videoIndex) {
    if (innerPageController.page!.round() + 1 <
        itemList[userIndex].videos.length) {
      innerPageController.nextPage(
          duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    } else if (innerPageController.page!.round() + 1 ==
        itemList[userIndex].videos.length) {
      pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  prevVideoInSameUser(int userIndex, int videoIndex) {
    if (innerPageController.page!.round() + 1 > 1) {
      innerPageController.previousPage(
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (itemList[modelIndex].likedByUser) {
      // itemList[modelIndex].likedByUser = false;
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.likeReel}/$eventId/like");
    } else {
      // itemList[modelIndex].likedByUser = true;
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.likeReel}/$eventId/like");
    }
    if (isDoneSuccefully == "Like added successfully") {
      itemList[modelIndex].likedByUser = true;
      itemList[modelIndex].likesCount += 1;
      update();
    } else if (isDoneSuccefully == "Like deleted successfully") {
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

  void nextUserPage() {
    if (currentUserIndex + 1 < itemList.length) {
      currentUserIndex++;
      pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);

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
