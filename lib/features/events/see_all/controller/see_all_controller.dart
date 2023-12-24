import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';

import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:evento/main.dart';
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

  late RxList<EventModel> itemList;

  late RxList<String> errorMessage;
late String targetRout;
late String mapKey;
late String pageTitle;
  @override
  void onInit() {
    isLoading = false.obs;
    isLoadingMoreData = false.obs;
    dataLimit = 4;
    pageId = Get.arguments[0]??1;
    hasMoreData = true.obs;
    errorMessage = <String>[].obs;
    itemList =Get.arguments[1]?? <EventModel>[].obs;
    targetRout=Get.arguments[2];
    mapKey=Get.arguments[3];
    pageTitle=Get.arguments[4];
    log(pageId.toString());
    scrollController = ScrollController();
    itemList.isEmpty?fetchData():null;
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          hasMoreData.value) {
        isLoadingMoreData.value = true;
        fetchData();
      }
    });
    super.onInit();
  }

  fetchData() async {
    isLoading.value = itemList.isNotEmpty ? false : true;

    String token = await prefService.readString("token") ?? "";
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
    log("dddddddddddddddddddddddddddddddddddddd");
    print(handlingResponse);
    log("dddddddddddddddddddddddddddddddddddddd");
    List<dynamic> categoryListJson = handlingResponse[mapKey]['data'];
    lastPageId = handlingResponse[mapKey]['last_page'];
log("message");
    itemList.addAll(categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList());
    if (pageId >= lastPageId  ){
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
