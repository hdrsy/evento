import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/follow_unfollow_event_api.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/controllers/pagination_controller.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/events/home/model/category_model.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:evento/features/events/home/model/organizer.dart';
import 'package:evento/main.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  late RxBool isLoading;
  @override
  void onInit() {
    isLoading = false.obs;

    super.onInit();
  }
  Future onrefresh()async{
    CategoryListController().onInit();
    FeaturedListController().onInit();
    EventInYourCityListController().onInit();
    OrganizerController().onInit();
    JustForYouController().onInit();
    TrendingListController().onInit();
    

  }
}

class CategoryListController extends GetxController {
  late RxBool isLoading;
  late RxList<CategoryModel> categoryList;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    isLoading = false.obs;
    categoryList = <CategoryModel>[  //// the tonight and this week is fixed in the list becuase this always exist
      CategoryModel(id: 0, title: "Tonight", icon:Get.isDarkMode? "assets/images/Asset_35.png":"assets/images/Asset_50.png"),
      CategoryModel(id: 0, title: "This Week", icon:Get.isDarkMode?"assets/images/Asset_28.png":"assets/images/Asset_47.png",),
    ].obs;
    errorMessage = <String>[].obs;
    fetchCategoryData();
    super.onInit();
  }

  fetchCategoryData() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.getCategoryList,
        method: "GEt",
        token: token);
    print(response);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();

      if(errorMessage[0]=="Invalid Token"){
        prefService.remove('token');
        Get.offAllNamed('/');
      }
    } else {
      whenGetDataSuccess(handlingResponse);
    }
    isLoading.value = false;
  }

  whenGetDataSuccess(handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['category'];

    categoryList.addAll(
        categoryListJson.map((jsonItem) => CategoryModel.fromJson(jsonItem)));
log("ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
    isLoading.value = false;
  }
}

class FeaturedListController extends PaginationController<EventModel> {
  FeaturedListController() : super(fetchDataCallback: _fetchData);

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ?? "";
    String apiUrl = "${ServerConstApis.getFeaturedList}?page=$page";

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
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      itemList[modelIndex].isFollowedByAuthUser = false;

      update();
    }
    log(itemList[modelIndex].isFollowedByAuthUser.toString());
  }
}

class EventInYourCityListController extends PaginationController<EventModel> {
  EventInYourCityListController() : super(fetchDataCallback: _fetchData);

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ?? "";
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
    List<dynamic> categoryListJson = handlingResponse['events_in_your_city']['data'];
    lastPageId = handlingResponse['events_in_your_city']['last_page'];

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
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      itemList[modelIndex].isFollowedByAuthUser = false;

      update();
    }
    log(itemList[modelIndex].isFollowedByAuthUser.toString());
  }
}

class OrganizerController extends PaginationController<OrganizerEvent> {
  OrganizerController() : super(fetchDataCallback: _fetchData);

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ?? "";
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
    List<dynamic> categoryListJson = handlingResponse['organizer_event']['data'];
    lastPageId = handlingResponse['organizer_event']['last_page'];
log("oooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    itemList.addAll(categoryListJson
        .map((jsonItem) => OrganizerEvent.fromJson(jsonItem))
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
  TrendingListController() : super(fetchDataCallback: _fetchData);

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ?? "";
    String apiUrl = "${ServerConstApis.getTrendingList}?page=$page";

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
    print(categoryListJson);
    lastPageId = handlingResponse['trending_event']['last_page'];

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
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      itemList[modelIndex].isFollowedByAuthUser = false;

      update();
    }
    log(itemList[modelIndex].isFollowedByAuthUser.toString());
  }
}
class JustForYouController extends PaginationController<EventModel> {
  JustForYouController() : super(fetchDataCallback: _fetchData);

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ?? "";
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
    print(categoryListJson);
    lastPageId = handlingResponse['just_for_you']['last_page'];

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
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      itemList[modelIndex].isFollowedByAuthUser = false;

      update();
    }
    log(itemList[modelIndex].isFollowedByAuthUser.toString());
  }
}
