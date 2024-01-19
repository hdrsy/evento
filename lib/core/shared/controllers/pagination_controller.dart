import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/services/cache_service.dart';
import 'package:evento/core/utils/services/check_internet.dart';
import '../../utils/error_handling/erroe_handling.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// PaginationController is a generic class for managing paginated data.
/// It is designed to be extended by specific controllers for different types of data.
///
/// Type [T] represents the type of data in the list (e.g., Event).
class PaginationController<T> extends GetxController {
  // A function that is responsible for fetching data. It takes the URL, page number, and any additional parameters.
  late Future<Either<ErrorResponse, Map<String, dynamic>>> Function(
          String url, int page, Map<String, dynamic> additionalParams)
      fetchDataCallback;

  // Reactive variables to track loading states.m
  late RxBool isLoading;
  late RxBool isLoadingMoreData;

  // A ScrollController to listen to scroll events for implementing 'load more' functionality.
  late ScrollController scrollController;

  // Variables for managing pagination.
  late int dataLimit;
  late int pageId;
  late int lastPageId;
  late RxBool hasMoreData;
  late CacheService cacheService;
  final String cacheKey;

  // A reactive list to hold the items of type [T].
  late RxList<T> itemList;

  // A reactive list to hold any error messages that might occur during data fetching.
  late RxList<String> errorMessage;

  // Constructor: Initializes variables and sets up the scroll listener.
  PaginationController(
      {required this.fetchDataCallback, required this.cacheKey}) {
    isLoading = false.obs;
    isLoadingMoreData = false.obs;
    dataLimit = 4;
    pageId = 1;
    hasMoreData = true.obs;
    errorMessage = <String>[].obs;
    itemList = <T>[].obs;
    scrollController = ScrollController();
    cacheService = cacheService = CacheService(cacheKey);
    // Scroll listener to handle 'load more' functionality on scroll.
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          hasMoreData.value) {
        isLoadingMoreData.value = true;
        fetchData();
      }
    });
  }

  // Called immediately after the controller is allocated memory. Initiates the first data fetch.
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Method to fetch data using the provided callback. It handles the response and updates the controller's state.
  fetchData() async {
    isLoading.value = itemList.isNotEmpty ? false : true;
    if (await checkInternet()) {
      log("from cache");
      final d = await cacheService.getObject<Map<String, dynamic>>(
        cacheKey: cacheKey,
        deserializeFunction: (jsonMap) => jsonMap,
      );
      print("$cacheKey : $d");
      if(d != null){

      handleDataSuccess(d);
      }else{
        isLoading.value=false;
      }
    } else {
      Either<ErrorResponse, Map<String, dynamic>> response =
          await fetchDataCallback('your-api-url', pageId,
              {}); // Replace 'your-api-url' and {} with actual values
      dynamic handlingResponse = response.fold((l) => l, (r) => r);

      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        handleDataSuccess(handlingResponse);
        cacheService.cacheObject<Map<String, dynamic>>(
          object: handlingResponse,
          cacheKey: cacheKey,
          serializeFunction: (data) => data,
        );
      }
    }
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  // A method that can be overridden in subclasses to handle data differently upon successful fetch.
  handleDataSuccess(dynamic handlingResponse) {
    // This method should be implemented in subclasses to handle successful data fetches.
  }

  // Cleans up the controller, disposing the scroll controller.
  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
  void handleNoCachedData() {
  // Implement logic for handling no cached data
  // For example, show a message to the user, update the UI, etc.
  log("No cached data available. Unable to fetch data from the server.");
  // You can update errorMessage or any other state variable to notify the user
  errorMessage.value = ["No internet connection and no cached data available."];
  // Update any other relevant state to reflect the situation
}
}
