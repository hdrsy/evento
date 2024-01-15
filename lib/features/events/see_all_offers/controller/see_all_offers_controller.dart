import 'package:dartz/dartz.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../home/model/offer_model.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SeeAllOffersController extends GetxController {
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

  late RxList<OfferEvent> itemList;

  late RxList<String> errorMessage;
  @override
  void onInit() {
    isLoading = false.obs;
    isLoadingMoreData = false.obs;
    dataLimit = 4;
    pageId = Get.arguments[0]??1;
    hasMoreData = false.obs;
    errorMessage = <String>[].obs;
    itemList =Get.arguments[1]?? <OfferEvent>[].obs;
    
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
   String apiUrl = "${ServerConstApis.getOfferList}?page=$pageId";

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
  
    List<dynamic> categoryListJson = handlingResponse["OfferEvent"]['data'];
    lastPageId = handlingResponse["OfferEvent"]['last_page'];

    itemList.addAll(categoryListJson
        .map((jsonItem) => OfferEvent.fromJson(jsonItem))
        .toList());
    if (pageId >= lastPageId  ){
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
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      itemList[modelIndex].isFollowedByAuthUser = false;

      update();
    }
   }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
