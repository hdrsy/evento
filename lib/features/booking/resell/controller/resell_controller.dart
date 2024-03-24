import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/booking/my_booking/controller/my_booking_controller.dart';
import 'package:evento/features/booking/resell/model/users_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReSellController extends GetxController {
  TextEditingController friendsSearch = TextEditingController();
  Timer? _debounce;
  var isSearchActive = false.obs;
  var isLoading = false.obs;
  RxBool isError = false.obs;
  var isLoadingMoreData = false.obs;
  var pageId = 1;
  var lastPageId = 1;
  var hasMoreData = true.obs;
  var itemList = <UsersModel>[].obs;
  var errorMessage = <String>[].obs;
  ScrollController scrollController = ScrollController();
  final int dataLimit = 4;
  RxInt selectedTicket = 0.obs;
  @override
  void onInit() {
    super.onInit();
    friendsSearch.addListener(_onSearchChanged);
    scrollController.addListener(_loadMoreData);
    initialFetchData();
  }

  void initialFetchData() async {
    await fetchData();
    // Conditionally fetch the next page if the first doesn't fill the screen.
    if (pageId == 1 && itemList.length == dataLimit) {
      pageId++;
      await fetchData();
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      isSearchActive.value = true;
      _fetchData(friendsSearch.text);
    });
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        hasMoreData.value) {
      pageId++;
      fetchData();
    }
  }

  Future<void> fetchData() async {
    try {
      if (isLoading.value || !hasMoreData.value) return;
      isLoading.value = isSearchActive.value ? false : true;
      isLoadingMoreData.value = pageId > 1;
      String token = await prefService.readString("token");
      var response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.freindSearch}?page=$pageId",
        method: "post",
        token: token,
        data: {"Search": friendsSearch.text},
      );

      response.fold(
        (error) => _handleError(error),
        (result) => _handleDataSuccess(result),
      );
      isLoading.value = false;
      isLoadingMoreData.value = false;
    } catch (e) {
      isLoading.value = false;
      isLoadingMoreData.value = false;

      isError.value = true;
    }
  }

  void _handleError(ErrorResponse error) {
    errorMessage.add(error.message ?? "");
    isError.value = true;
    update(); // Trigger UI update
  }

  void _handleDataSuccess(Map<String, dynamic> data) {
    var newItems = (data["result"]['data'] as List)
        .map((jsonItem) => UsersModel.fromJson(jsonItem))
        .toList();
    if (pageId == 1) itemList.clear();
    itemList.addAll(newItems);
    lastPageId = data["result"]['last_page'];
    hasMoreData.value = pageId < lastPageId;
    update(); // Trigger UI update
  }

  @override
  void onClose() {
    friendsSearch.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  void _fetchData(String query) {
    pageId = 1;
    hasMoreData.value = true;
    itemList.clear();
    initialFetchData(); // Use initialFetchData to potentially fetch two pages if needed
  }

  onPressAddFreind(int userId, int modelId) async {
    // itemList[modelId].friendRequestStatus = 'pending';
    isLoading.value = true;
    update();
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.reSellTicket}",
        method: "post",
        data: {"user_id": userId, "ticket_id": selectedTicket.value},
        token: token);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    print("thrResell :$handlingResponse");
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      Get.isRegistered<MyBookingController>()
          ? Get.find<MyBookingController>().onInit()
          : null;

      Get.back();
    }
    isLoading.value = false;
  }
}
