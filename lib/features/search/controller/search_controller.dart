
import 'package:dartz/dartz.dart';
import 'package:evento/core/server/filter.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/controllers/pagination_controller.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends PaginationController<EventModel> {
  SearchPageController() : super(fetchDataCallback: _fetchData,cacheKey: "SearchPageController");
  RxList<EventModel> searchResultSearch=<EventModel>[].obs;
   RxBool isSearchActive=false.obs;
  late TextEditingController searchField=TextEditingController();
  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ;
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
  void onPressSearch(String query) {
  if (query.isEmpty) {
    isSearchActive.value = false;
    searchResultSearch.clear();
  } else {
    isSearchActive.value = true;
    searchResultSearch.assignAll(
      itemList.where(
        (event) => event.title.toLowerCase().contains(query.toLowerCase())
      ).toList()
    );
  }
}
void onApplyFilters(Map<String ,dynamic> data)async{
  isSearchActive.value=true;
  final d=await  filter( data);
  print(d);
Get.back();
    var eventModels = d.map((jsonItem) => EventModel.fromJson(jsonItem)).toList();
  searchResultSearch.addAll(eventModels.cast<EventModel>());

}

}
