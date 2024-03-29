import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/features/events/customize_event/service_category/model/service_category_model.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class SeeAllServiceCategoryController extends GetxController {
  late RxList<ServiceCategoryModel> serviceCategoryList;
  late RxBool isLoading;
  RxBool isError = false.obs;

  late RxList<String> errorMessage;
  @override
  void onInit() async {
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    serviceCategoryList = <ServiceCategoryModel>[].obs;
    await fetchCategoryData();

    super.onInit();
  }

  fetchCategoryData() async {
    isLoading.value = true;
    try {
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.serviceCategory,
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
      isError.value = true;
      isLoading.value = false;
    }
  }

  whenGetDataSuccess(handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['category'];

    serviceCategoryList.addAll(categoryListJson
        .map((jsonItem) => ServiceCategoryModel.fromJson(jsonItem)));
    log(serviceCategoryList.length.toString());
    // isLoading.value = false;
  }
}
