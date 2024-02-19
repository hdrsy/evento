import 'package:evento/features/organizer/show_all_booking_in_event_for_orgnaizer/model/show_all_booking_in_event_for_organizer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAllBookingInEventForOrganizerController extends GetxController {
  late RxBool isLoading;
  late RxBool hasMoreData;
  late ScrollController scrollController;
  late RxList<ShowAllBookingInEventForOrganizerModel> itemList;
  @override
  void onInit() {
    isLoading = false.obs;
    hasMoreData = false.obs;
    itemList = <ShowAllBookingInEventForOrganizerModel>[].obs;
    scrollController = ScrollController();
    getdata();
    // TODO: implement onInit
    super.onInit();
  }

  getdata() {
    itemList.value = fakeBookingData
        .map((json) => ShowAllBookingInEventForOrganizerModel.fromJson(json))
        .toList();
  }
}

List<Map<String, dynamic>> fakeBookingData = [
  {
    "id": 1,
    "profile": "https://example.com/profiles/profile1.jpg",
    "lastName": "Doe",
    "firstName": "John",
  },
  {
    "id": 2,
    "profile": "https://example.com/profiles/profile2.jpg",
    "lastName": "Smith",
    "firstName": "Jane",
  },
  {
    "id": 3,
    "profile": "https://example.com/profiles/profile3.jpg",
    "firstName": "Emily",
    "lastName": "Johnson",
  },
  // Add more fake data as needed
];