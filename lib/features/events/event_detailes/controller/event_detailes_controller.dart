import 'dart:developer';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/services/cache_service.dart';
import 'package:evento/core/utils/services/check_internet.dart';
import 'package:evento/core/utils/services/connectivity_service.dart';
import 'package:evento/core/utils/services/snackbar_manager.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/services/location_service.dart';
import '../model/event_detailes_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailesController extends GetxController {
  @override
  void onClose() {
    // LocationService().();
    super.onClose();
  }

  late EventDetailsModel eventDetailsModel;
  late RxBool isLoading;
  late int eventId;
  RxString distance = "0 km".obs;
  late RxList<String> errorMessage;
  late RxList<EventModel> relatedEvents;
  bool isOffer = false;
  int offerPrecent = 0;
  CacheService cacheService = CacheService('eventDetailes');
  late String cacheKey;
  late RxBool isSomeThingError;
  final ConnectivityService _connectivityService = Get.find();
  bool isSameUser = false;
  @override
  void onInit() async {
    errorMessage = <String>[].obs;
    relatedEvents = <EventModel>[].obs;
    isLoading = false.obs;
    isSomeThingError = false.obs;
    eventId = Get.arguments[0];
    print("event is is :$eventId");
    isOffer = Get.arguments[1] ?? false;
    offerPrecent = Get.arguments[2] ?? 0;
    cacheKey = "eventDetailes$eventId";
    _connectivityService.isConnected.listen((isConnected) {
      if (isConnected) {
        getEventDetailesModel();
        isSomeThingError.value = false;
        SnackbarManager.showSnackbar(
          "Online",
          "You are back online.",
          icon: Icon(Icons.wifi_outlined, color: customColors.primaryText),
          backgroundColor: customColors.primaryBackground,
        );
      } else {
        print("You are offline!");
        SnackbarManager.showSnackbar(
          "",
          "No internet connection.",
          icon: Icon(Icons.wifi_off_outlined, color: customColors.primaryText),
          backgroundColor: customColors.primaryBackground,
        );
      }
    });
    await getEventDetailesModel();
    await calculateDistance();

    super.onInit();
  }

  getEventDetailesModel() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    // try {
    print("token $token");
    if (await checkInternet()) {
      log("from cache");
      final d = await cacheService.getObject<Map<String, dynamic>>(
        cacheKey: cacheKey,
        deserializeFunction: (jsonMap) => jsonMap,
      );
      print("d:$d");
      if (d != null) {
        whenGetDataSuccess(d);
      } else {
        isSomeThingError.value = true;
        isLoading.value = false;
      }
      isLoading.value = false;
    } else {
      response = await ApiHelper.makeRequest(
          targetRout:
              "${isGuset ? ServerConstApis.getEventDetailesforGuest : ServerConstApis.getEventDetailes}/$eventId",
          method: "GEt",
          token: token);
      print("the event detials response: $response");
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isSomeThingError.value = true;
        print(
            "the event detials response: ${handlingResponse.getErrorMessages()}");
      } else {
        whenGetDataSuccess(handlingResponse);

        cacheService.cacheObject<Map<String, dynamic>>(
          object: handlingResponse,
          cacheKey: cacheKey,
          serializeFunction: (data) => data,
        );
      }
      isLoading.value = false;
    }
    // } catch (e) {
    //   print(e);
    //   isSomeThingError.value = true;
    //   isLoading.value = false;
    // }
  }

  whenGetDataSuccess(handlingResponse) {
    eventDetailsModel = EventDetailsModel.fromJson(handlingResponse['event']);
    print("objectrrrrr:${eventDetailsModel.organizer}");
    isSameUser = isGuset
        ? true
        : eventDetailsModel.organizer != null
            ? user!.id == eventDetailsModel.organizer!.id
            : false;
    relatedEvents.value = List<EventModel>.from(
        handlingResponse['relatedEvents'].map((x) => EventModel.fromJson(x)));
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

  Future<void> openLink(String link) async {
    try {
      if (!await launchUrl(Uri.parse(link))) {
        throw Exception('Could not launch $link');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  calculateDistance() async {
    LocationService locationService = LocationService();
    try {
      distance.value = await locationService.calculateDistance(
          eventDetailsModel.venue.latitude, eventDetailsModel.venue.longitude);
    } catch (e) {
      distance.value = "0 km";
    }
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
