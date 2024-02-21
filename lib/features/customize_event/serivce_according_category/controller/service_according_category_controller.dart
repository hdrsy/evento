import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/service_according_category_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class ServiceAccordingCategoryController extends GetxController {
  late RxList<ServiceProvider> serviceProviderList;
  late int serviceAccordingCategoryIndex;
  late RxBool isLoading;
  RxBool isError = false.obs;
  late String serviceCategoryType;
  late RxList<String> errorMessage;
  late int serviceCategoryIndex;
  late bool isInCustomuzEvent;

  @override
  void onInit() async {
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    serviceProviderList = <ServiceProvider>[].obs;

    serviceAccordingCategoryIndex = Get.arguments[0];
    serviceCategoryType = Get.arguments[1];
    serviceCategoryIndex = Get.arguments[2];
    isInCustomuzEvent = Get.arguments[3];

    log(serviceCategoryIndex.toString());
    await fetchData();
    super.onInit();
  }

  fetchData() async {
    try {
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout:
              "${ServerConstApis.serviceAccordingCategory}/$serviceAccordingCategoryIndex",
          method: "GEt",
          token: token);
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isError.value = true;
      } else {
        whenGetDataSuccess(handlingResponse);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }
  }

  whenGetDataSuccess(handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['service_provider'];

    serviceProviderList.addAll(
        categoryListJson.map((jsonItem) => ServiceProvider.fromJson(jsonItem)));
// log(serviceCategoryList.length.toString());
    // isLoading.value = false;
  }
}
