import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/services/cache_service.dart';
import 'package:evento/core/utils/services/check_internet.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/service_category_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class ServiceCategoryController extends GetxController {
  late RxList<ServiceCategoryModel> serviceCategoryList;
  late RxBool isLoading;
  RxBool isError = false.obs;
  late List<RxInt> selectedServiceProviders;
  late RxList<String> errorMessage;
  late RxInt selectedVenue;
  Map selected = {};
  CacheService cacheService = CacheService('ServiceCategory');
  final String cacheKey = 'ServiceCategory';

  @override
  void onInit() async {
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    serviceCategoryList = <ServiceCategoryModel>[].obs;
    selectedServiceProviders = [];
    selectedVenue = 0.obs;
    await fetchCategoryData();
    selectedServiceProviders = List.generate(
        serviceCategoryList.length,
        (index) => 0
            .obs); //// each service categry have index so i store in the id the serivce provider selected

    super.onInit();
  }

  bool isSelectedServiceProvider(int id, int serviceCategoryIndex) {
    return selectedServiceProviders[serviceCategoryIndex].value == id;
  }

  changeSelectedServiceProviderInEachCategory(int serviceProviderId,
      int serviceCategoryIndex, String serviceProviderName) {
    ////to select new service provider and unselected one
    if (selectedServiceProviders[serviceCategoryIndex].value ==
        serviceProviderId) {
      selectedServiceProviders[serviceCategoryIndex].value = 0;
      selected.remove(serviceCategoryList[serviceCategoryIndex].title);
    } else {
      selectedServiceProviders[serviceCategoryIndex].value = serviceProviderId;
      selected[serviceCategoryList[serviceCategoryIndex].title] =
          serviceProviderName;
    }
    update();
  }

  changeSelectedVenue(int venueIndex, String venueName) {
    ////to select new service provider and unselected one
    if (selectedVenue.value == venueIndex) {
      selectedVenue.value = 0;
      selected.remove("Venue Name");
    } else {
      selectedVenue.value = venueIndex;
      selected["Venue Name"] = venueName;
    }
    update();
  }

  int selectedServiceProvidersNumbers() {
    int number = 0;
    for (var i = 0; i < selectedServiceProviders.length; i++) {
      selectedServiceProviders[i].value != 0 ? number++ : null;
    }
    selectedVenue.value == 0 ? null : number++;
    return number;
  }

  fetchCategoryData() async {
    try {
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      if (await checkInternet()) {
        final d = await cacheService.getObject<Map<String, dynamic>>(
          cacheKey: cacheKey,
          deserializeFunction: (jsonMap) => jsonMap,
        );
        if (d != null) {
          whenGetDataSuccess(d);
        } else {
          isLoading.value = false;
        }
      } else {
        response = await ApiHelper.makeRequest(
            targetRout: ServerConstApis.serviceCategory,
            method: "GEt",
            token: token);

        dynamic handlingResponse = response.fold((l) => l, (r) => r);
        if (handlingResponse is ErrorResponse) {
          isError.value = true;
          errorMessage.value = handlingResponse.getErrorMessages();
        } else {
          whenGetDataSuccess(handlingResponse);
          cacheService.cacheObject<Map<String, dynamic>>(
            object: handlingResponse,
            cacheKey: cacheKey,
            serializeFunction: (data) => data,
          );
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }
  }

  whenGetDataSuccess(handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['category'];

    serviceCategoryList.addAll(categoryListJson
        .map((jsonItem) => ServiceCategoryModel.fromJson(jsonItem)));
    log(serviceCategoryList.length.toString());
    log(selectedServiceProviders.length.toString());
    // isLoading.value = false;
  }
}
