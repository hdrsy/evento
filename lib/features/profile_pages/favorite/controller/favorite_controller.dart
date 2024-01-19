import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/services/location_service.dart';
import '../model/favorite_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  late List<EventWrapper> favoriteEvents;
  late List<RxString> distances;
  late RxList<String> errorMessage;

  @override
  void onInit() async{
    favoriteEvents = [];
    errorMessage = <String>[].obs;
    distances = [];
   await getMyFavoriteEvents();
   calculateDistance();
    super.onInit();
  }

  getMyFavoriteEvents() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myFavoriteEvents,
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['events'];

      favoriteEvents = interestsJson
          .map((jsonItem) => EventWrapper.fromJson(jsonItem))
          .toList();
          print(favoriteEvents);
     distances=List.generate(favoriteEvents.length, (index) => "0 Km".obs);
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

   calculateDistance() async {
    LocationService locationService = LocationService();
    for (var i = 0; i < favoriteEvents.length; i++) {
      distances[i]=(await locationService.calculateDistance(favoriteEvents[i].event.venue.latitude, favoriteEvents[i].event.venue.longitude)).obs;
   print(distances[i].value);
    }
    
  }
}
