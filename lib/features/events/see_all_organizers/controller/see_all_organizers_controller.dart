import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../home/model/home_oganizer.dart';
import '../../../../main.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SeeAllOrganizersController extends GetxController {
  late String rout;
  late RxBool isLoading;
  late RxBool isLoadingMoreData;

  // A ScrollController to listen to scroll events for implementing 'load more' functionality.
  late ScrollController scrollController;
  TextEditingController searchController = TextEditingController();

  // Variables for managing pagination.
  late int dataLimit;
  late int pageId;
  late int lastPageId;
  late RxBool hasMoreData;
  RxBool isSearchActive = false.obs;

  late RxList<OrganizerHome> itemList;
  late RxList<OrganizerHome> searchItemList;
  Timer? _debounce;
  late RxList<String> errorMessage;
  late String targetRout;
  late String mapKey;
  late String pageTitle;
  @override
  void onInit() {
    isLoading = false.obs;
    isLoadingMoreData = false.obs;
    dataLimit = 4;
    pageId = Get.arguments[0] ?? 1;
    hasMoreData = false.obs;
    errorMessage = <String>[].obs;
    itemList = <OrganizerHome>[].obs;
    itemList.assignAll(Get.arguments[1] ?? <OrganizerHome>[].obs);
    targetRout = Get.arguments[2];
    mapKey = Get.arguments[3];
    pageTitle = Get.arguments[4];
    log(pageId.toString());
    searchController.addListener(_onSearchChanged);
    searchItemList = <OrganizerHome>[].obs;

    scrollController = ScrollController();
    itemList.isEmpty
        ? fetchData()
        : pageId == 2
            ? (fetchData())
            : log(pageId.toString());

    null;
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

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        // onPressSearch(searchField.text);
        isSearchActive.value = true;
        searchItemList.assignAll(itemList
            .where((event) => event.organizerHomeInfo.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList());
        print("inisde the timer ");
      } else {
        // Optionally handle empty search field case
        // _fetchData("");
        isSearchActive.value = false;
      }
    });
  }

  fetchData() async {
    isLoading.value = itemList.isNotEmpty ? false : true;
    hasMoreData.value = true;
    log("page id $pageId");
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

    itemList.addAll(categoryListJson
        .map((jsonItem) => OrganizerHome.fromJson(jsonItem))
        .toList());
    if (pageId >= lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  followOrUnFollowOrganizer(int organizerId, int modelIndex) async {
    late String isDoneSuccefully;
    if (itemList[modelIndex].organizerHomeInfo.isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowOrganizer}/$organizerId");
    } else {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.followOrganizer}/$organizerId");
    }
    if (isDoneSuccefully == "followed successfully") {
      itemList[modelIndex].organizerHomeInfo.isFollowedByAuthUser = true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      itemList[modelIndex].organizerHomeInfo.isFollowedByAuthUser = false;

      update();
    }
    log(itemList[modelIndex].organizerHomeInfo.isFollowedByAuthUser.toString());
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
