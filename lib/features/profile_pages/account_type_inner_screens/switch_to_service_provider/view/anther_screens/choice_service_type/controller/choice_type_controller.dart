import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../core/server/helper_api.dart';
import '../../../../../../../../core/server/server_config.dart';
import '../../../../../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../../../../customize_event/service_category/model/service_category_model.dart';
import '../../../../../../../../main.dart';
import 'package:get/get.dart';

class ChoiceTypeController extends GetxController {
  late RxList<String> errorMessage;
  late RxList<ServiceCategoryModel> serviceCategoryList;
  late RxList<ServiceCategoryModel> searchserviceCategoryList;
  late RxList<int> selectedCategories;
  TextEditingController searchController = TextEditingController();

  late RxBool isLoading;
  late ScrollController scrollController;
  var isSearchActive = false.obs;

  @override
  void onInit() async {
    errorMessage = <String>[].obs;
    selectedCategories = <int>[].obs;
    isLoading = false.obs;
    searchController.addListener(_onSearchChanged);
    searchserviceCategoryList = <ServiceCategoryModel>[].obs;

    serviceCategoryList = <ServiceCategoryModel>[].obs;
    await fetchCategoryData();

    super.onInit();
  }

  Timer? _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        // onPressSearch(searchField.text);
        isSearchActive.value = true;
        searchserviceCategoryList.assignAll(serviceCategoryList
            .where((event) => event.title
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList());
        print("inisde the timer ");
      } else {
        // Optionally handle empty search field case
        // _fetchData("");
        isSearchActive.value = false;
      }
    });
  }

  changeSelectedService(int categoryId) {
    selectedCategories.contains(categoryId)
        ? selectedCategories.remove(categoryId)
        : selectedCategories.add(categoryId);
    update();
  }

  onPressDone() {
    if (selectedCategories.isEmpty) {
      errorMessage.add("Please select at least one category");
      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 50),
                curve: Curves.easeInOut,
              ));
    } else {
      Get.toNamed('/ServiceProviderCreateProfileScreen');
    }
  }

  fetchCategoryData() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
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
    // isLoading.value = false;
  }
}

class ChoiceServiceTypeModel {
  final String name;

  ChoiceServiceTypeModel({
    required this.name,
  });
}
