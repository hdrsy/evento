import 'dart:developer';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/services/location_service.dart';
import '../model/event_detailes_model.dart';
import '../model/related_event_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailesController extends GetxController {
  @override
  void onClose() {
    LocationService().stopTracking();
    super.onClose();
  }

  late EventDetailsModel eventDetailsModel;
  late RxBool isLoading;
  late int eventId;
  RxString distance = "0 km".obs;
  late RxList<String> errorMessage;
  late List<RelatedEventModel> relatedEvents;
  late bool isOffer;
  late int offerPrecent;
  @override
  void onInit() async {
    errorMessage = <String>[].obs;
    isLoading = false.obs;
    eventId = Get.arguments[0];
    isOffer = Get.arguments[1] ?? false;
    offerPrecent = Get.arguments[2] ?? 0;

    await getEventDetailesModel();
    await calculateDistance();

    super.onInit();
  }

  getEventDetailesModel() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout:
            "${isGuset ? ServerConstApis.getEventDetailesforGuest : ServerConstApis.getEventDetailes}/$eventId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      whenGetDataSuccess(handlingResponse);
    }
    isLoading.value = false;
  }

  whenGetDataSuccess(handlingResponse) {
    eventDetailsModel = EventDetailsModel.fromJson(handlingResponse['event']);
    relatedEvents = List<RelatedEventModel>.from(
        handlingResponse['relatedEvents']
            .map((x) => RelatedEventModel.fromJson(x)));
  }

  followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (relatedEvents[modelIndex].isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      relatedEvents[modelIndex].isFollowedByAuthUser = true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      relatedEvents[modelIndex].isFollowedByAuthUser = false;

      update();
    }
    log(relatedEvents[modelIndex].isFollowedByAuthUser.toString());
  }

  void createAndAddReminderEvents() async {
    // Reminder 24 hours before the main event
    final Event reminder24h = Event(
      title: 'Reminder: ${eventDetailsModel.title} (24 hours before)',
      description:
          'This is a reminder for the event: ${eventDetailsModel.description}',
      location: eventDetailsModel.venue.governorate,
      startDate:
          eventDetailsModel.startDate.subtract(const Duration(hours: 24)),
      endDate: eventDetailsModel.startDate.subtract(
          const Duration(hours: 23, minutes: 45)), // 15 minutes duration
      iosParams:
          const IOSParams(reminder: Duration(minutes: 0)), // Immediate reminder
      androidParams: const AndroidParams(emailInvites: []),
    );

    // Reminder 3 hours before the main event
    final Event reminder3h = Event(
      title: 'Reminder: ${eventDetailsModel.title} (3 hours before)',
      description:
          'This is a reminder for the event: ${eventDetailsModel.description}',
      location: eventDetailsModel.venue.governorate,
      startDate: eventDetailsModel.startDate.subtract(const Duration(hours: 3)),
      endDate: eventDetailsModel.startDate.subtract(
          const Duration(hours: 2, minutes: 45)), // 15 minutes duration
      iosParams:
          const IOSParams(reminder: Duration(minutes: 0)), // Immediate reminder
      androidParams: const AndroidParams(emailInvites: []),
    );

    bool wasAdded24h = await Add2Calendar.addEvent2Cal(reminder24h);

    // Adding the 3-hour reminder
    bool wasAdded3h = await Add2Calendar.addEvent2Cal(reminder3h);

    // Displaying one Snackbar based on both operations
    if (wasAdded24h && wasAdded3h) {
      Get.snackbar(
        "Success",
        "This Event added to Your calendar",
        snackPosition: SnackPosition.TOP,
        backgroundColor: customColors.primaryBackground,
        colorText: customColors.primaryText,
      );
    } else {
      Get.snackbar(
        "Failed",
        "Failed to add This Event to Your calendar",
        snackPosition: SnackPosition.TOP,
        backgroundColor: customColors.primaryBackground,
        colorText: customColors.primaryText,
      );
    }
  }

  Future<void> openMap() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${eventDetailsModel.venue.latitude},${eventDetailsModel.venue.longitude}';
    try {
      if (!await launchUrl(Uri.parse(googleUrl))) {
        throw Exception('Could not launch $googleUrl');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  calculateDistance() async {
    LocationService locationService = LocationService();
    distance.value = await locationService.calculateDistance(
        eventDetailsModel.venue.latitude, eventDetailsModel.venue.longitude);
  }

  followAndUnFollowOrganizer() async {
    late String isDoneSuccefully;
    if (eventDetailsModel.isOrganizerFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowOrganizer}/${eventDetailsModel.organizerId}");
    } else {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.followOrganizer}/${eventDetailsModel.organizerId}");
    }
    if (isDoneSuccefully == "followed successfully") {
      eventDetailsModel.isOrganizerFollowedByAuthUser = true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      eventDetailsModel.isOrganizerFollowedByAuthUser = false;

      update();
    }
    // log(itemList[modelIndex].isFollowedByAuthUser.toString());
  }
}
