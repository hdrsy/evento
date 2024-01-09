import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/customize_event/service_category/model/service_category_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class SeeAllServiceCategoryController extends GetxController {
  late RxList<ServiceCategoryModel> serviceCategoryList;
  late RxBool isLoading;
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
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.serviceCategory,
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
    List<dynamic> categoryListJson = handlingResponse['category'];

    serviceCategoryList.addAll(categoryListJson
        .map((jsonItem) => ServiceCategoryModel.fromJson(jsonItem)));
    log(serviceCategoryList.length.toString());
    // isLoading.value = false;
  }
}
