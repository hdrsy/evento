import 'package:dartz/dartz.dart';
import 'package:evento/core/server/follow_unfollow_event_api.dart';
import 'package:evento/features/reel_pages/reels/model/reels_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';

import '../../../../main.dart';
import 'dart:developer';

import 'package:get/get.dart';

class ShowReelController extends GetxController {
  late RxBool isLoading;
  late RxBool isLoadingMoreData;

  // A ScrollController to listen to scroll events for implementing 'load more' functionality.
  late PageController pageController;
  late int currentUserIndex = 0; // Index of the current user
  late PageController innerPageController = PageController();
  RxBool isError = false.obs;
  // Variables for managing pagination.
  late int dataLimit;
  late int pageId;
  late int lastPageId;
  late RxBool hasMoreData;
  RxList<ReelModel> itemList = <ReelModel>[].obs;
  late int reelId;
  late RxList<String> errorMessage;
  bool isfristRequest = true;
  @override
  void onInit() async {
    reelId = int.tryParse(Get.parameters['id'] ?? "1") ?? 1;

    isLoading = false.obs;
    isLoadingMoreData = false.obs;
    hasMoreData = true.obs;
    dataLimit = 4;
    pageId = 1;
    errorMessage = <String>[].obs;

    pageController = PageController();
    // itemList.isEmpty ? fetchData() : null;
    await fetchData();
    pageController.addListener(() {
      if (pageController.position.maxScrollExtent == pageController.offset &&
          hasMoreData.value) {
        // if (isStartPagination) {
        isLoadingMoreData.value = true;
        fetchData();
      }
      // }
    });
    super.onInit();
  }

  fetchData() async {
    isLoading.value = true;
    try {
      String token = await prefService.readString("token");
      String apiUrl =
          "${isGuset ? ServerConstApis.showReel : ServerConstApis.showReel}/$reelId?page=$pageId";

      Either<ErrorResponse, Map<String, dynamic>> response =
          await ApiHelper.makeRequest(
        targetRout: apiUrl,
        method: "GET",
        token: token,
      );
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      print(handlingResponse);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isError.value = true;
      } else {
        handleDataSuccess(handlingResponse);
      }
    } catch (e) {
      print(e);
      isError.value = true;
    }
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  handleDataSuccess(dynamic handlingResponse) {
    print(handlingResponse);
    if (!isfristRequest) {
      print("inside fffffff");
      List<dynamic> categoryListJson = handlingResponse["otherReels"]['data'];
      lastPageId = handlingResponse["otherReels"]['last_page'];

      itemList.addAll(categoryListJson
          .map((jsonItem) => ReelModel.fromJson(jsonItem))
          .toList());
    } else {
      itemList.add(ReelModel.fromJson(handlingResponse['requestedReel']));
      lastPageId = 2;
      isfristRequest = false;
      hasMoreData.value = true;
      pageId = 1;
      isLoadingMoreData.value = true;
    }
    if (pageId >= lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
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
    // if (isStartPagination) {
    if (currentUserIndex + 1 < itemList.length) {
      currentUserIndex++;
      pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);

      update();
      // }
    }
  }

  void previousUser() {
    if (currentUserIndex > 0) {
      currentUserIndex--;
      update();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
