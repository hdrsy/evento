import 'package:dartz/dartz.dart';
import 'package:evento/core/server/follow_unfollow_event_api.dart';
import 'package:evento/features/reel_pages/reels/model/reels_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';

import '../../../../main.dart';

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
  bool isFirstRequest = true;
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
      isGuset = await prefService.isContainKey("token") ? false : true;

      String token = await prefService.readString("token");
      String apiUrl =
          "${isGuset ? ServerConstApis.showReelforGuest : ServerConstApis.showReel}/$reelId?page=$pageId";

      Either<ErrorResponse, Map<String, dynamic>> response =
          await ApiHelper.makeRequest(
        targetRout: apiUrl,
        method: "GET",
        token: token,
      );
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isError.value = true;
      } else {
        handleDataSuccess(handlingResponse);
      }
    } catch (e) {
      isError.value = true;
    }
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  handleDataSuccess(dynamic handlingResponse) {
    if (isFirstRequest) {
      // Handle the initial request by adding the requestedReel.
      itemList
          .clear(); // Clear if you want only fresh data, or remove if you want to append.
      itemList.add(ReelModel.fromJson(handlingResponse['requestedReel']));
      List<dynamic> categoryListJson = handlingResponse["otherReels"]['data'];
      lastPageId = handlingResponse["otherReels"]['last_page'];
      itemList.addAll(categoryListJson
          .map((jsonItem) => ReelModel.fromJson(jsonItem))
          .toList());
      pageId++;

      isFirstRequest = false;
      hasMoreData.value = handlingResponse["otherReels"]['last_page'] > 2;
      pageId = 2; // Assuming next page to fetch after initial reel is page 2.
    } else {
      // Handle pagination by adding other reels.
      List<dynamic> categoryListJson = handlingResponse["otherReels"]['data'];
      lastPageId = handlingResponse["otherReels"]['last_page'];

      itemList.addAll(categoryListJson
          .map((jsonItem) => ReelModel.fromJson(jsonItem))
          .toList());
      hasMoreData.value = pageId < lastPageId;
      pageId++;
    }
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
      // There are more items in the list, simply navigate to the next user's reel.
      currentUserIndex++;
      pageController.animateToPage(
        currentUserIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      update(); // If using GetX or similar for state management to update the UI.
    } else if (hasMoreData.value) {
      // The end of the list is reached and there's more data to fetch.
      fetchData().then((_) {
        // After fetching data, navigate to the next reel if data was successfully loaded.
        if (currentUserIndex + 1 < itemList.length) {
          currentUserIndex++;
          pageController.animateToPage(
            currentUserIndex,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
          update(); // Update the UI to reflect changes.
        }
      }).catchError((error) {
        // Handle any errors during data fetching.
      });
    }
    // If there's no more data to load, you might want to handle this scenario as well (e.g., showing a message).
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
