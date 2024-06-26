import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/filter.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';
import 'package:evento/features/search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/services/location_service.dart';
import '../model/favorite_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  late RxList<EventWrapper> favoriteEvents;
  late List<RxString> distances;
  final EventStateManager eventStateManager = Get.find();

  late RxList<String> errorMessage;
  RxList<EventWrapper> searchResultSearch = <EventWrapper>[].obs;
  RxBool isSearchActive = false.obs;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  late TextEditingController searchField = TextEditingController();

  @override
  void onInit() async {
    favoriteEvents = <EventWrapper>[].obs;
    errorMessage = <String>[].obs;
    isLoading = false.obs;
    distances = [];
    await getMyFavoriteEvents();
    calculateDistance();
    getuserlocation();
    super.onInit();
  }

  getuserlocation() async {
    // userLocation = await locationService.getCurrentLocation();
  }

  getMyFavoriteEvents() async {
    try {
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.myFavoriteEvents,
          method: "GEt",
          token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isError.value = true;
      } else {
        List<dynamic> interestsJson = handlingResponse['events'];

        favoriteEvents.value = interestsJson
            .map((jsonItem) => EventWrapper.fromJson(jsonItem))
            .toList();
        distances = List.generate(favoriteEvents.length, (index) => "0 Km".obs);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }
  }

  followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (favoriteEvents[modelIndex].isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      favoriteEvents[modelIndex].isFollowedByAuthUser = true;
      eventStateManager.toggleFavorite(eventId);

      update();
    } else if (isDoneSuccefully == "removed successfully") {
      favoriteEvents[modelIndex].isFollowedByAuthUser = false;
      eventStateManager.toggleFavorite(eventId);

      update();
    }
    log(favoriteEvents[modelIndex].isFollowedByAuthUser.toString());
  }

  calculateDistance() async {
    // LocationService locationService = LocationService();
    for (var i = 0; i < favoriteEvents.length; i++) {
      distances[i].value = (await LocationService.calculateDistance(
          favoriteEvents[i].venue.latitude, favoriteEvents[i].venue.longitude));
    }
  }

  void onPressSearch(String query) {
    if (query.isEmpty) {
      isSearchActive.value = false;
      searchResultSearch.clear();
    } else {
      isSearchActive.value = true;
      searchResultSearch.assignAll(favoriteEvents
          .where((event) =>
              event.title.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }

  void onApplyFilters(Map<String, dynamic> data) async {
    isSearchActive.value = true;
    isLoading.value = true;
    Get.back();
    final d = await filter(data, url: ServerConstApis.favoritefilter);
    var eventModels =
        d.map((jsonItem) => EventWrapper.fromJson(jsonItem)).toList();
    searchResultSearch.addAll(eventModels.cast<EventWrapper>());
    isLoading.value = false;
  }
}
