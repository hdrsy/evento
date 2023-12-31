import 'package:dartz/dartz.dart';
import 'package:evento/core/server/follow_unfollow_event_api.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/organizer/organizer_profile/model/organizer_profile_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class OrganizerProfileController extends GetxController {
  late OrganizerProfileModel organizerProfileModel;
  late RxList<String> errorMessage;
late RxBool isLoading;
late int orgnizerId;
  @override
  void onInit() {
    errorMessage = <String>[].obs;
    isLoading=false.obs;
    orgnizerId=Get.arguments;
    getOrganizerProfile();
    // TODO: implement onInit
    super.onInit();
  }

  getOrganizerProfile() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    isLoading.value=true;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.organizerProfile}/$orgnizerId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      final interestsJson = handlingResponse['organizer'];

      organizerProfileModel = OrganizerProfileModel.fromJson(interestsJson);
      update();
    }
    isLoading.value=false;
  }
    followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (organizerProfileModel.organizedEvents[modelIndex] .isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      organizerProfileModel.organizedEvents[modelIndex].isFollowedByAuthUser = true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      organizerProfileModel.organizedEvents[modelIndex].isFollowedByAuthUser = false;

      update();
    }
   }

  followOrUnFollowOrganizer(int organizerId) async {
    late String isDoneSuccefully;
    if (organizerProfileModel.organizerInfo.isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowOrganizer}/$organizerId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followOrganizer}/$organizerId");
    }
    if (isDoneSuccefully == "followed successfully") {
      organizerProfileModel.organizerInfo.isFollowedByAuthUser = true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      organizerProfileModel.organizerInfo.isFollowedByAuthUser = false;

      update();
    }
   }

}
