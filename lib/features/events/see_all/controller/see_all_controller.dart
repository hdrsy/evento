import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/follow_unfollow_event_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/services/location_service.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';
import '../../../../core/server/helper_api.dart';

import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../home/model/event_model.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllController extends GetxController {
  late String rout;
  late RxBool isLoading;
  late RxBool isLoadingMoreData;

  // A ScrollController to listen to scroll events for implementing 'load more' functionality.
  late ScrollController scrollController;

  // Variables for managing pagination.
  late int dataLimit;
  late int pageId;
  late int lastPageId;
  late RxBool hasMoreData;
  final EventStateManager eventStateManager=Get.find();
  late List<RxString> distances;
  late RxList<EventModel> itemList;

  late RxList<String> errorMessage;
  late String targetRout;
  late String mapKey;
  late String pageTitle;
  @override
  void onInit() {
    isLoading = false.obs;
    isLoadingMoreData = false.obs;
    distances=[];
    dataLimit = 4;
    pageId = Get.arguments[0] ?? 1;
    hasMoreData = false.obs;
    errorMessage = <String>[].obs;
    itemList = Get.arguments[1] ?? <EventModel>[].obs;
    targetRout = Get.arguments[2];
    mapKey = Get.arguments[3];
    pageTitle = Get.arguments[4] ?? "";
    log(pageId.toString());
    scrollController = ScrollController();
    itemList.isEmpty ? fetchData() : null;
    itemList.isNotEmpty?(
    distances.addAll(List.generate(itemList.length, (index) => "0 km".obs))
    ):null;
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          hasMoreData.value) {
        isLoadingMoreData.value = true;
        fetchData();
      }
    });
    calculateDistance();
    super.onInit();
  }

  fetchData() async {
    isLoading.value = itemList.isNotEmpty ? false : true;

    String token = await prefService.readString("token");
    String apiUrl = "$targetRout?page=$pageId";

    Either<ErrorResponse, Map<String, dynamic>> response =
        await ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
    dynamic handlingResponse = response.fold((l) => l, (r) => r);

    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      handleDataSuccess(handlingResponse);
    }
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse[mapKey]['data'];
    lastPageId = handlingResponse[mapKey]['last_page'];
    var ll=categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList();
    for(int i=0;i<ll.length;i++){
      eventStateManager.addOrUpdateEvent(ll[i]);
    }

    itemList.addAll(categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList());
    distances.addAll(List.generate(categoryListJson.length, (index) => "0".obs));


    if (pageId >= lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }
  followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (itemList[modelIndex].isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
      await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      itemList[modelIndex].isFollowedByAuthUser = true;
      eventStateManager.toggleFavorite(eventId);
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      itemList[modelIndex].isFollowedByAuthUser = false;
      eventStateManager.toggleFavorite(eventId);

      update();
    }
    log(itemList[modelIndex].isFollowedByAuthUser.toString());
  }
  calculateDistance() async {
    LocationService locationService = LocationService();
    for (var i = 0; i < itemList.length; i++) {
      distances[i] = (await locationService.calculateDistance(
          itemList[i].venue!.lang,
          itemList[i].venue!.long))
          .obs;

      print("event id $i distance is ${distances[i].value}");
    }
    update();
  }



  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
