import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/my_events_for_organizer_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class MyEventsForOrganizerController extends GetxController {
  late List<MyEventsForOrganizerModel> myRequestsList;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  @override
  void onInit() {
    myRequestsList = [];
    errorMessage = <String>[].obs;
    isLoading = false.obs;
    getMyEventRequests();
    super.onInit();
  }

  getMyEventRequests() async {
    // isLoading.value = true;
    // Either<ErrorResponse, Map<String, dynamic>> response;
    // String token = await prefService.readString("token") ?? "";
    // response = await ApiHelper.makeRequest(
    //     targetRout: ServerConstApis.myEventRequest,
    //     method: "GEt",
    //     token: token);

    // dynamic handlingResponse = response.fold((l) => l, (r) => r);
    // if (handlingResponse is ErrorResponse) {
    //   errorMessage.value = handlingResponse.getErrorMessages();
    // } else {
    // List<dynamic> interestsJson = handlingResponse['data'];

    myRequestsList = fakeEventsJson
        .map((jsonItem) => MyEventsForOrganizerModel.fromJson(jsonItem))
        .toList();
    //   isLoading.value = false;
    //   update();
    // }
  }
}

// Simulating JSON data as a Dart object
List<Map<String, dynamic>> fakeEventsJson = [
  {
    "id": 1,
    "title": "Annual Tech Expo",
    "first_name": "John",
    "last_name": "Doe",
    "phone_number": "123456789",
    "date": "2023-10-15",
    "start_time": "09:00",
    "end_time": "17:00",
    "adults": 150,
    "child": 50,
    "images": jsonEncode(
        ["https://example.com/image1.jpg", "https://example.com/image2.jpg"]),
    "description": "A gathering of tech enthusiasts.",
    "additional_notes": "Bring your gadgets.",
    "status": "Confirmed",
    "category_id": 1,
    "category": {
      "title": "Technology",
    },
    "service_providers": [
      {
        "id": 101,
        "category_id": 2,
        "category": {
          "title": "Catering",
        },
        "user": {
          "first_name": "Alice",
          "last_name": "Johnson",
        },
      }
    ],
    "venue": {
      "id": 201,
      "name": "Convention Center",
    },
  },
  // Add more events as needed
];
