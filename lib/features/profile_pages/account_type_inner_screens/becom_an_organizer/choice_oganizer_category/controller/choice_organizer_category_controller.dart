import 'dart:async';

import '../../../../../events/home/controller/home_controller.dart';
import '../../../../../events/home/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceOrganizerCategoryController extends GetxController {
  late List<ChoiceOrganizerCategoryTypeModel> choiceServiceList;
  late RxList<ChoiceOrganizerCategoryTypeModel> searchchoiceServiceList;
  TextEditingController sericeSelected = TextEditingController();
  TextEditingController searchController = TextEditingController();
  late RxList<int> selectedCategories;
  late ScrollController scrollController;
  var isSearchActive = false.obs;

  late RxList<String> errorMessage;
  Timer? _debounce;
  @override
  void onInit() {
    scrollController = ScrollController();
    choiceServiceList = [];
    selectedCategories = <int>[].obs;
    errorMessage = <String>[].obs;
    searchController.addListener(_onSearchChanged);
    searchchoiceServiceList = <ChoiceOrganizerCategoryTypeModel>[].obs;
    getCategoriesList();
    super.onInit();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        // onPressSearch(searchField.text);
        isSearchActive.value = true;
        searchchoiceServiceList.assignAll(choiceServiceList
            .where((event) => event.name
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

  getCategoriesList() {
    final CategoryListController categoryListController = Get.find();
    List<CategoryModel> categories = [];
    categories.assignAll(categoryListController.categoryList);
    categories.removeAt(0);
    categories.removeAt(0);
    for (var element in categories) {
      choiceServiceList.add(ChoiceOrganizerCategoryTypeModel(
          name: element.title, categoryId: element.id));
    }
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
      Get.toNamed('/OrganizerCreateProfileScreen');
    }
  }
}

class ChoiceOrganizerCategoryTypeModel {
  final String name;
  final int categoryId;

  ChoiceOrganizerCategoryTypeModel(
      {required this.name, required this.categoryId});
}
