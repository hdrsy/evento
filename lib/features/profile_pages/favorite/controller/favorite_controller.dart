import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/follow_unfollow_event_api.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/services/location_service.dart';
import 'package:evento/features/profile_pages/favorite/model/favorite_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController{
  late List<EventWrapper> favoriteEvents;
  late RxList<String> errorMessage;

 @override
  void onInit() {
   favoriteEvents=[];
    errorMessage=<String>[].obs;
   getMyFavoriteEvents();
    super.onInit();
  } 
  getMyFavoriteEvents() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myFavoriteEvents, method: "GEt", token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['events'];

      favoriteEvents = interestsJson
          .map((jsonItem) => EventWrapper.fromJson(jsonItem))
          .toList();

      update();

    }
  }
  followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (favoriteEvents[modelIndex].event.isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      favoriteEvents[modelIndex].event.isFollowedByAuthUser = true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      favoriteEvents[modelIndex].event.isFollowedByAuthUser = false;

      update();
    }
    log(favoriteEvents[modelIndex].event.isFollowedByAuthUser.toString());
  }
  calculateDistance(double latitude,double longitude) async {
    LocationService locationService = LocationService();
    return  await locationService.calculateDistance(
latitude, longitude);
  }

}