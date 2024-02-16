import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/organizer_profile_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class OrganizationProfileController extends GetxController {
  late OrganizationProfileModel organizerProfileModel;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  // late int orgnizerId;
// late bool isorganizerEditProfile;

  @override
  void onInit() {
    errorMessage = <String>[].obs;
    isLoading = false.obs;
    // orgnizerId = Get.arguments;
    // isorganizerEditProfile = Get.arguments[1]??false;
    organizerProfileModel =
        OrganizationProfileModel.fromJson(fakeOrganizationProfileData);
    getOrganizerProfile();
    // TODO: implement onInit
    super.onInit();
  }

  getOrganizerProfile() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    isLoading.value = true;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.organizerProfile}/1",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    print(handlingResponse);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      print("handling :$handlingResponse");
      final interestsJson = handlingResponse['organizer'];

      organizerProfileModel = OrganizationProfileModel.fromJson(interestsJson);
      print("organization: ${organizerProfileModel.organizedEvents}");
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

// Example of fake data for OrganizationProfileModel
var fakeOrganizationProfileData = {
  "id": 1,
  "followers_count": 150,
  "following_count": 75,
  "organized_events_count": 10,
  "organizer_info": {
    "id": 1,
    "name": "Event Organizer Inc.",
    "bio": "We organize the best events.",
    "services": "Event Planning and Management",
    "state": "Active",
    "profile": "https://example.com/profile.jpg",
    "cover": "https://example.com/cover.jpg",
    "is_followed_by_auth_user": true,
    "albums": [
      {
        "id": 1,
        "name": "Event Highlights",
        "images": jsonEncode([
          "https://example.com/image1.jpg",
          "https://example.com/image2.jpg"
        ]),
        "videos": jsonEncode([
          "https://example.com/video1.mp4",
          "https://example.com/video2.mp4"
        ]),
      }
    ],
    "categories": [
      {
        "id": 1,
        "title": "Music",
        "icon": "https://example.com/icons/music.png",
      },
      {
        "id": 2,
        "title": "Technology",
        "icon": "https://example.com/icons/tech.png",
      }
    ]
  },
  "organized_events": [
    {
      "id": 1,
      "organizer_id": 1,
      "title": "Tech Conference 2023",
      "venue_id": 1,
      "capacity": 500,
      "start_date": "2023-09-15T09:00:00Z",
      "end_date": "2023-09-15T18:00:00Z",
      "ticket_price": 99,
      "description": "A tech conference focusing on the latest in technology.",
      "type": "Conference",
      "videos": null,
      "images": jsonEncode([
        "https://example.com/event1/image1.jpg",
        "https://example.com/event1/image2.jpg"
      ]),
      "is_followed_by_auth_user": false,
    }
  ]
};

// Parsing the fake data to create an OrganizationProfileModel instance

// print(organizationProfileModel.organizerInfo.name); // Should print "Event Organizer Inc."
