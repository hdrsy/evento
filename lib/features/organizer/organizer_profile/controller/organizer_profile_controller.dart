import 'package:dartz/dartz.dart';
import 'package:evento/features/organizer/organizer_profile/model/organizer_profile_followers_model.dart';
import 'package:evento/features/profile_pages/profile/controller/profile_controller.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/organizer_profile_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class OrganizerProfileController extends GetxController {
  late OrganizerProfileModel organizerProfileModel;
  late RxList<String> errorMessage;
  late List<OrganizerFollowersModel> rganizerFollowers;
  late RxBool isLoading;
  late RxBool isLoadingFollowers;
  late int orgnizerId;
  late bool isSameUser;
// late bool isorganizerEditProfile;

  @override
  void onInit() async {
    isSameUser = false;
    errorMessage = <String>[].obs;
    isLoading = false.obs;
    isLoadingFollowers = false.obs;
    rganizerFollowers = [];
    orgnizerId = Get.arguments;
    // isorganizerEditProfile = Get.arguments[1]??false;
    checkIfSameUser();
    await getOrganizerProfile();
    getOrganizerFollowers(); // TODO: implement onInit
    super.onInit();
  }

  getOrganizerProfile() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    isLoading.value = true;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.organizerProfile}/$orgnizerId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    print(handlingResponse);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      final interestsJson = handlingResponse['organizer'];

      organizerProfileModel = OrganizerProfileModel.fromJson(interestsJson);
      update();
    }
    isLoading.value = false;
  }

  getOrganizerFollowers() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    isLoadingFollowers.value = true;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.organizerFollowers}/$orgnizerId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    print(handlingResponse);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      final List<dynamic> interestsJson =
          handlingResponse['followers']['followers'];
      rganizerFollowers
          .addAll(interestsJson.map<OrganizerFollowersModel>((jsonItem) {
        return OrganizerFollowersModel.fromJson(jsonItem);
      }).toList());
      updateFriendRequestStatus(rganizerFollowers);
      print("organizer followers id:$rganizerFollowers");
      // organizerProfileModel = OrganizerProfileModel.fromJson(interestsJson);
      update();
    }
    isLoadingFollowers.value = false;
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

  void updateFriendRequestStatus(List<OrganizerFollowersModel> models) {
    final ProfileController profileController = Get.find();
    for (var model in models) {
      // Assuming a match is defined as having the same id
      if (model.id == profileController.profileModel.id) {
        model.friendRequestStatusWithAuthUser = 'me';
      }
    }
  }

  checkIfSameUser() {
    final ProfileController profileController = Get.find();
    isSameUser = orgnizerId == profileController.profileModel.id ? true : false;
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
    if (organizerProfileModel.organizerInfo.isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowOrganizer}/$organizerId");
    } else {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.followOrganizer}/$organizerId");
    }
    if (isDoneSuccefully == "followed successfully") {
      organizerProfileModel.organizerInfo.isFollowedByAuthUser = true;
      organizerProfileModel.followersCount++;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      organizerProfileModel.organizerInfo.isFollowedByAuthUser = false;
      organizerProfileModel.followersCount--;

      update();
    }
  }
}
