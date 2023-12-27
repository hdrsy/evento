import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/features/customize_event/date_time/controller/date_time_controller.dart';
import 'package:evento/features/customize_event/review/model/contact_info_model.dart';
import 'package:evento/features/customize_event/review/model/event_over_view.dart';
import 'package:evento/features/customize_event/service_category/controller/service_category_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        date: DateFormatter.formatDate(dateTimeController.date));
  }

  onPressDone() async {
    final ServiceCategoryController serviceCategoryController = Get.find();

    final DateTimeController dateTimeController = Get.find();
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    Map<String, dynamic> dataRequest = {
      "first_name": contactInfoModel.firstName,
      "last_name": contactInfoModel.lastName,
      "phone_number": contactInfoModel.phoneNumber,
      "people": contactInfoModel.adultNumber + contactInfoModel.childrenNumber,
      "date": eventOverView.date,
      "description": dateTimeController.description.text,
      "venue_id": serviceCategoryController.selectedVenue.value,
      "service_provider_id": serviceCategoryController.selectedServiceProviders,
      "additional_notes": notes.text,
    };
    Map<String, File> fileMap = {};
    for (int i = 0; i < dateTimeController.media.length; i++) {
      fileMap['images'] = dateTimeController.media[i];
    }
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.sendRequest,
        method: "POST",
        token: token,
        data: dataRequest,
        files: fileMap);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    log("Ggggggggggggggggggggggggggggggggggg");
    print(handlingResponse);
    log("Ggggggggggggggggggggggggggggggggggg");
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
      isLoading.value = false;
      return false;
    } else {
      return true;
    }
  }
}
