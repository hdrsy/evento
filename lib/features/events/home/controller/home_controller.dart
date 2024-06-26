import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/services/battery_optimzation.dart';

import 'package:evento/core/utils/services/cache_service.dart';
import 'package:evento/core/utils/services/check_internet.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/shared/controllers/pagination_controller.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/category_model.dart';
import '../model/event_model.dart';
import '../model/home_oganizer.dart';
import '../model/offer_model.dart';
import '../../../../main.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  late RxBool isLoading;
  var loadedWidgetsCount = 4.obs; // Start with 2 widgets loaded
  final int totalWidgetsCount = 9; // Total number of widgets you have

  void loadMoreWidgets() {
    if (loadedWidgetsCount.value < totalWidgetsCount) {
      loadedWidgetsCount.value += 2; // Load 2 more widgets at a time
      if (loadedWidgetsCount.value > totalWidgetsCount) {
        loadedWidgetsCount.value =
            totalWidgetsCount; // Don't exceed total count
      }
    }
  }

  @override
  void onInit() async {
    isLoading = false.obs;
    String isIgnoiedRequest = await prefService.readString("battery");
    bool isIgnoried = await Pushy.isIgnoringBatteryOptimizations();
    if (!isGuset && isIgnoiedRequest == '') {
      isIgnoried ? null : showBatteryOptimizationDialog();
      await prefService.createString("battery", "true");
    }
    super.onInit();
  }

  Future onrefresh() async {
    Get.find<CategoryListController>().onInit();
    Get.find<FeaturedListController>().refreshData();
    Get.find<TrendingListController>().refreshData();

    isGuset ? null : Get.find<EventsforOrganizerListController>().refreshData();
    Get.find<OffersController>().refreshData();
    isGuset ? null : Get.find<EventInYourCityListController>().refreshData();
    isGuset ? null : Get.find<HomeOrganizerController>().refreshData();
    isGuset ? null : Get.find<JustForYouController>().refreshData();
  }
}

class CategoryListController extends GetxController {
  late RxBool isLoading;
  late RxList<CategoryModel> categoryList;
  late RxList<String> errorMessage;
  CacheService cacheService = CacheService('categoryListCache');
  final String cacheKey = 'categoryList';
  // final ConnectivityService _connectivityService = Get.find();

  @override
  void onInit() {
    isLoading = false.obs;
    categoryList = <CategoryModel>[
      //// the tonight and this week is fixed in the list becuase this always exist
      CategoryModel(
        id: 0,
        title: "Tonight",
        icon: "assets/images/Asset_48.png",
      ),
      CategoryModel(
        id: 0,
        title: "This Week",
        icon: "assets/images/Asset_51.png",
      ),
    ].obs;
    errorMessage = <String>[].obs;
    fetchCategoryData();

    super.onInit();
  }

  fetchCategoryData() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    if (await checkInternet()) {
      log("from cache");
      final d = await cacheService.getObject<Map<String, dynamic>>(
        cacheKey: cacheKey,
        deserializeFunction: (jsonMap) => jsonMap,
      );
      if (d != null) {
        whenGetDataSuccess(d);
      } else {
        isLoading.value = false;
      }
    } else {
      response = await ApiHelper.makeRequest(
          targetRout: isGuset
              ? ServerConstApis.getCategoryListforGuest
              : ServerConstApis.getCategoryList,
          method: "GEt",
          token: token);
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();

        if (errorMessage[0] == "Invalid Token") {
          prefService.remove('token');
          prefService.remove('userInfo');
          Get.offAllNamed('/');
        }
        if (errorMessage[0] == "please complete your info") {
          Get.offAllNamed('/');
        }
      } else {
        whenGetDataSuccess(handlingResponse);
        cacheService.cacheObject<Map<String, dynamic>>(
          object: handlingResponse,
          cacheKey: cacheKey,
          serializeFunction: (data) => data,
        );
      }
    }
    isLoading.value = false;
  }

  whenGetDataSuccess(handlingResponse) async {
    List<dynamic> categoryListJson = handlingResponse['category'];

    categoryList.addAll(
        categoryListJson.map((jsonItem) => CategoryModel.fromJson(jsonItem)));
    isLoading.value = false;
    // Cache the current page data
  }
}

class EventsforOrganizerListController
    extends PaginationController<EventModel> {
  EventsforOrganizerListController()
      : super(
            fetchDataCallback: _fetchData, cacheKey: "EventsforOrganizerList");
  final EventStateManager eventStateManager = Get.find();

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl = "${ServerConstApis.getOrganizerEventList}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson =
        handlingResponse['organizer_event']['data'];
    lastPageId = handlingResponse['organizer_event']['last_page'];

    itemList.addAll(categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList());
    if (pageId == lastPageId) {
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
}

class OffersController extends PaginationController<OfferEvent> {
  OffersController() : super(fetchDataCallback: _fetchData, cacheKey: "Offers");

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl =
        "${isGuset ? ServerConstApis.getOfferListforGuest : ServerConstApis.getOfferList}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['OfferEvent']['data'];
    lastPageId = handlingResponse['OfferEvent']['last_page'];

    itemList.addAll(categoryListJson
        .map((jsonItem) => OfferEvent.fromJson(jsonItem))
        .toList());
    if (pageId == lastPageId) {
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
    log(itemList[modelIndex].isFollowedByAuthUser.toString());
  }
}

class FeaturedListController extends PaginationController<EventModel> {
  FeaturedListController()
      : super(fetchDataCallback: _fetchData, cacheKey: "FeaturedList");
  final EventStateManager eventStateManager = Get.find();
  RxBool isSoundEnabled = false.obs;
  bool sound() {
    isSoundEnabled.value = !isSoundEnabled.value;
    return isSoundEnabled.value;
  }

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl =
        "${isGuset ? ServerConstApis.getFeaturedListforGuest : ServerConstApis.getFeaturedList}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['featured_event']['data'];
    lastPageId = handlingResponse['featured_event']['last_page'];
    var ll = categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList();
    for (int i = 0; i < ll.length; i++) {
      eventStateManager.addOrUpdateEvent(ll[i]);
    }

    itemList.addAll(categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList());
    if (pageId == lastPageId) {
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
  }
}

class EventInYourCityListController extends PaginationController<EventModel> {
  EventInYourCityListController()
      : super(fetchDataCallback: _fetchData, cacheKey: "EventInYourCityList");
  final EventStateManager eventStateManager = Get.find();

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl = "${ServerConstApis.getInyourCityList}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson =
        handlingResponse['events_in_your_city']['data'];
    lastPageId = handlingResponse['events_in_your_city']['last_page'];
    var ll = categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList();
    for (int i = 0; i < ll.length; i++) {
      eventStateManager.addOrUpdateEvent(ll[i]);
    }

    itemList.addAll(categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList());
    if (pageId == lastPageId) {
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
}

class HomeOrganizerController extends PaginationController<OrganizerHome> {
  HomeOrganizerController()
      : super(fetchDataCallback: _fetchData, cacheKey: "HomeOrganizer");

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl = "${ServerConstApis.getOrganizerHomeList}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    log("the organizer executed");
    List<dynamic> categoryListJson = handlingResponse['organizers']['data'];
    lastPageId = handlingResponse['organizers']['last_page'];
    itemList.addAll(categoryListJson
        .map((jsonItem) => OrganizerHome.fromJson(jsonItem))
        .toList());
    if (pageId == lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }
}

class TrendingListController extends PaginationController<EventModel> {
  TrendingListController()
      : super(fetchDataCallback: _fetchData, cacheKey: "TrendingList");
  final EventStateManager eventStateManager = Get.find();
  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl =
        "${isGuset ? ServerConstApis.getTrendingListforGuest : ServerConstApis.getTrendingList}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['trending_event']['data'];
    lastPageId = handlingResponse['trending_event']['last_page'];

    var ll = categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList();
    for (int i = 0; i < ll.length; i++) {
      eventStateManager.addOrUpdateEvent(ll[i]);
    }
    itemList.addAll(categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList());
    if (pageId == lastPageId) {
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
}

class JustForYouController extends PaginationController<EventModel> {
  JustForYouController()
      : super(fetchDataCallback: _fetchData, cacheKey: "JustForYou");
  final EventStateManager eventStateManager = Get.find();

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl = "${ServerConstApis.getJustForYouList}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['just_for_you']['data'];
    log("message");
    lastPageId = handlingResponse['just_for_you']['last_page'];
    var ll = categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList();
    for (int i = 0; i < ll.length; i++) {
      eventStateManager.addOrUpdateEvent(ll[i]);
    }

    itemList.addAll(categoryListJson
        .map((jsonItem) => EventModel.fromJson(jsonItem))
        .toList());
    if (pageId == lastPageId) {
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
      eventStateManager.toggleFavorite(eventId);

      itemList[modelIndex].isFollowedByAuthUser = false;

      update();
    }
    log(itemList[modelIndex].isFollowedByAuthUser.toString());
  }
}
