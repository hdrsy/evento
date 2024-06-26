import 'dart:async';

import 'package:evento/core/server/filter.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/services/cache_service.dart';
import 'package:evento/core/utils/services/location_service.dart';
import 'package:evento/features/search/model/search_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// Add your other necessary imports here
LocationService locationService = LocationService();
late Position userLocation;

class SearchPageController extends GetxController {
  var searchResults = <SearchModel>[].obs;
  var recentSearch = <SearchModel>[].obs;
  var isSearchActive = false.obs;
  var isError = false.obs;
  var isLoading = false.obs;
  TextEditingController searchField = TextEditingController();
  Timer? _debounce;
  CacheService cacheService = CacheService('searchRecent');
  final String cacheKey = 'searchRecent';

  @override
  void onInit() async {
    super.onInit();
    _fetchData(""); // Fetch initial data with empty query
    searchField.addListener(_onSearchChanged);
    await getRecentSearch();
    getuserlocation();
  }

  getuserlocation() async {
    userLocation = await LocationService.getCurrentLocation();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchField.text.isNotEmpty) {
        onPressSearch(searchField.text);
      } else {
        // Optionally handle empty search field case
        _fetchData("");
        isSearchActive.value = false;
      }
    });
  }

  Future<void> getRecentSearch() async {
    final jsonString = await cacheService.getObject<Map<String, dynamic>>(
      cacheKey: cacheKey,
      deserializeFunction: (jsonMap) => jsonMap,
    );
    if (jsonString != null) {
      var results = (jsonString['result'] as List)
          .map((jsonItem) => SearchModel.fromJson(jsonItem))
          .toList();

      recentSearch.addAll(results);
    }
  }

  bool _isSavingToCache = false;

  void addNewEventToCache(SearchModel searchModel) async {
    if (_isSavingToCache) return; // Prevent concurrent access
    _isSavingToCache = true;
    if (!recentSearch.any((item) => item.id == searchModel.id)) {
      recentSearch.add(searchModel);
      if (recentSearch.length > 10) {
        // Limit to 10 recent searches
        recentSearch.removeAt(0);
      }
      // Serialize the entire recentSearch list to JSON within a map

      Map<String, dynamic> resultMap = {
        'result': recentSearch.map((item) => item.toJson()).toList()
      };
      // String jsonList = jsonEncode(resultMap);
      await cacheService.cacheObject<Map<String, dynamic>>(
        object: resultMap,
        cacheKey: cacheKey,
        serializeFunction: (string) => string,
      );
    } else {}
  }

  void _fetchData(String query) async {
    try {
      isLoading.value = true;
      String token = await prefService.readString("token");
      var response = await ApiHelper.makeRequest(
          targetRout: isGuset
              ? ServerConstApis.eventSearchforGuest
              : ServerConstApis.eventSearch,
          method: "post",
          data: {"Search": query},
          token: token);

      response.fold(
        (error) => _handleError(error),
        (result) => _handleSuccess(result),
      );
    } catch (e) {
      isError.value = true;
    }
    isLoading.value = false;
  }

  void _handleError(ErrorResponse error) {
    isError.value = true;
    // Handle your error, maybe show a snackbar or log it
    // Get.snackbar("Error", error.message); // Example
  }

  void _handleSuccess(Map<String, dynamic> data) {
    var results = (data['result'] as List)
        .map((jsonItem) => SearchModel.fromJson(jsonItem))
        .toList();
    _updateSearchResults(results);
  }

  void _updateSearchResults(List<SearchModel> results) {
    searchResults.clear();
    searchResults.assignAll(results);
    update();
  }

  void onPressSearch(String query) {
    isSearchActive.value = query.isNotEmpty;
    if (isSearchActive.isTrue) {
      _fetchData(query);
    } else {
      _fetchData("");

      update();
      // _updateSearchResults([]);
    }
  }

  void onApplyFilters(Map<String, dynamic> data) async {
    isSearchActive.value = true;
    isLoading.value = true;
    update();
    // Your filter logic
    Get.back();
    var filteredData = await filter(
        data); // Assuming this returns List<dynamic> representing filtered data
    if (filteredData is List<dynamic>) {
      List<SearchModel> filteredResults = filteredData.map((jsonItem) {
        // Ensure jsonItem is a Map<String, dynamic> before converting
        return SearchModel.fromJson(jsonItem);
      }).toList();
      _updateSearchResults(filteredResults);
    } else {
      // Handle the case where filte
      //redData is not a List<dynamic>
      // For example, log an error or show an error message
    }
    isLoading.value = false;
    // isSearchActive.value = true;
  }

  resetController() {
    searchField.clear();
    isSearchActive.value = false;
    isError.value = false;
    _fetchData(" "); // Fetch initial data with empty query
  }

  @override
  void onClose() {
    searchField.dispose();
    _debounce?.cancel();
    super.onClose();
  }
}
