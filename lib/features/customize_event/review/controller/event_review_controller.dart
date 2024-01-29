import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../date_time/controller/date_time_controller.dart';
import '../model/contact_info_model.dart';
import '../model/event_over_view.dart';
import '../../service_category/controller/service_category_controller.dart';
import '../../type_to_set_event/controller/type_to_set_event_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventReviewController extends GetxController {
  late ContactInfoModel contactInfoModel;
  late EventOverView eventOverView;
  late TextEditingController notes;
  late Map selected;
  late RxBool isLoading;
  late RxList<String> errorMessage;

  @override
  void onInit() {
    notes = TextEditingController();
    getContactInfo();
    getoverViewInfo();
    getSelectedserviceProvider();
    isLoading = false.obs;
    errorMessage = <String>[].obs;

    super.onInit();
  }

  getSelectedserviceProvider() {
    final ServiceCategoryController serviceCategoryController = Get.find();
    selected = serviceCategoryController.selected;
  }

  getContactInfo() {
    final DateTimeController dateTimeController = Get.find();
    contactInfoModel = ContactInfoModel(
        firstName: dateTimeController.firstName.text,
        lastName: dateTimeController.lastName.text,
        phoneNumber: dateTimeController.phoneNumber.text,
        adultNumber: dateTimeController.adultNumber.value,
        childrenNumber: dateTimeController.childrenNumber.value);
  }

  getoverViewInfo() {
    final DateTimeController dateTimeController = Get.find();
    eventOverView = EventOverView(
        startTime: dateTimeController.startTime,
        endTime: dateTimeController.endTime,
        date: dateTimeController.date);
  }

  onPressDone() async {
    isLoading.value = true;
    final ServiceCategoryController serviceCategoryController = Get.find();
    final TypetoSetEventController typetoSetEventController = Get.find();

    final DateTimeController dateTimeController = Get.find();

    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    // Assuming 'dateTimeController.date' is a DateTime object
    String formattedDate =
        DateFormat('yyyy-MM-dd', 'en').format(dateTimeController.date);

// Assuming 'dateTimeController.startTime' and 'dateTimeController.endTime' are DateTime objects
    String formattedStartTime =
        DateFormat('HH:mm:ss', 'en').format(dateTimeController.startTime);
    String formattedEndTime =
        DateFormat('HH:mm:ss', 'en').format(dateTimeController.endTime);

    Map<String, dynamic> dataRequest = {
      "first_name": contactInfoModel.firstName,
      "last_name": contactInfoModel.lastName,
      "phone_number": contactInfoModel.phoneNumber,
      "adults": contactInfoModel.adultNumber,
      "child": contactInfoModel.childrenNumber,
      "date": formattedDate,
      "description": dateTimeController.description.text,
      "venue_id": serviceCategoryController.selectedVenue.value,
      "additional_notes": notes.text,
      "category_id": typetoSetEventController.selectedCategory.value,
      "start_time": formattedStartTime,
      "end_time": formattedEndTime,
      "title": dateTimeController.eventTitle.text
    };
    List<int> serviceProviderIds = serviceCategoryController
        .selectedServiceProviders
        .map((rxInt) => rxInt.value)
        .toList();

    // for (int i = 0; i < serviceProviderIds.length; i++) {
    //   print(serviceProviderIds[i]);
    //   if (serviceProviderIds[i] != 0) {
    //     dataRequest['service_provider_id[$i]'] =
    //         serviceProviderIds[i].toString();
    //   }
    // }
    dataRequest['service_provider_id'] = serviceProviderIds;
    Map<String, File> fileMap = {};
    for (int i = 0; i < dateTimeController.media.length; i++) {
      fileMap['images[$i]'] = dateTimeController.media[i];
    }

    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.sendEventRequest,
        method: "POST",
        token: token,
        data: dataRequest,
        files: fileMap);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    log("Ggggggggggggggggggggggggggggggggggg");
    log("Ggggggggggggggggggggggggggggggggggg");
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
      isLoading.value = false;
    } else {
      isLoading.value = false;

      Get.toNamed('/PaymentScreen');
    }
  }
}

DateTime parseTime(String timeString) {
  final standardizedTimeString = standardizeTimeFormat(timeString);
  final format = DateFormat("hh:mm a"); // Format for "09:01 AM"

  TimeOfDay timeOfDay =
      TimeOfDay.fromDateTime(format.parse(standardizedTimeString));

  final now = DateTime.now();
  return DateTime(
      now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
}

String standardizeTimeFormat(String timeString) {
  // Convert AM/PM part to uppercase to match the expected format
  String modifiedTimeString = timeString.toUpperCase();

  DateFormat inputFormat = DateFormat("h:m a");
  DateFormat outputFormat = DateFormat("hh:mm a");

  try {
    DateTime dateTime = inputFormat.parse(modifiedTimeString);
    return outputFormat.format(dateTime);
  } catch (e) {
    return timeString;
  }
}
