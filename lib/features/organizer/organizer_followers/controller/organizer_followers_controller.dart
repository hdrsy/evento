import 'package:dartz/dartz.dart';
import 'package:evento/features/organizer/organization_profile/model/organizer_profile_model.dart';
import 'package:evento/features/organizer/organizer_profile/model/organizer_profile_followers_model.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class OrganizerFollowersController extends GetxController {
  late OrganizationProfileModel organizerProfileModel;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  RxBool isError = false.obs;
  late List<OrganizerFollowersModel> rganizerFollowers;

  // late int orgnizerId;
// late bool isorganizerEditProfile;

  @override
  void onInit() async {
    errorMessage = <String>[].obs;
    isLoading = false.obs;
    rganizerFollowers = [];
    await getOrganizerProfile();
    await getOrganizerFollowers();
    super.onInit();
  }

  getOrganizerProfile() async {
    try {
      Either<ErrorResponse, Map<String, dynamic>> response;
      isLoading.value = true;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.organizationProfile,
          method: "GEt",
          token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isError.value = true;
      } else {
        final interestsJson = handlingResponse['organizer'];

        organizerProfileModel =
            OrganizationProfileModel.fromJson(interestsJson);
        update();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }
  }

  getOrganizerFollowers() async {
    isLoading.value = true;

    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout:
            "${ServerConstApis.organizerFollowers}/${organizerProfileModel.id}",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      final List<dynamic> interestsJson = handlingResponse['followers'];
      rganizerFollowers
          .addAll(interestsJson.map<OrganizerFollowersModel>((jsonItem) {
        return OrganizerFollowersModel.fromJson(jsonItem);
      }).toList());
      update();
    }
    isLoading.value = false;
  }

  followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (organizerProfileModel
        .organizedEvents[modelIndex].isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      organizerProfileModel.organizedEvents[modelIndex].isFollowedByAuthUser =
          true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      organizerProfileModel.organizedEvents[modelIndex].isFollowedByAuthUser =
          false;

      update();
    }
  }

  followOrUnFollowOrganizer(int organizerId) async {
    late String isDoneSuccefully;
    if (organizerProfileModel.isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowOrganizer}/$organizerId");
    } else {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.followOrganizer}/$organizerId");
    }
    if (isDoneSuccefully == "followed successfully") {
      organizerProfileModel.isFollowedByAuthUser = true;
      organizerProfileModel.followersCount++;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      organizerProfileModel.isFollowedByAuthUser = false;
      organizerProfileModel.followersCount--;

      update();
    }
  }

  onPressAddFreind(int userId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.freindRequest}/$userId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      rganizerFollowers[modelId].friendRequestStatusWithAuthUser = 'pending';
      update();
    }
  }

  onPressCancelReques(int requestId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.cancelRequest}/$requestId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      rganizerFollowers[modelId].friendRequestStatusWithAuthUser = null;
      update();
    }
  }
}
