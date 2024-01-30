import 'package:evento/core/utils/theme/theme_controller.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';

import '../../customize_event/type_to_set_event/controller/type_to_set_event_controller.dart';
import '../../events/home/controller/home_controller.dart';
import 'main_bottom_navigation_controller.dart';
import '../../profile_pages/profile/controller/profile_controller.dart';
import '../../reels/controller/reels_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Import your controller

class MainBottomNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainBottomNavigationController>(
        () => MainBottomNavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoryListController>(() => CategoryListController());
    Get.lazyPut<FeaturedListController>(() => FeaturedListController());
    Get.lazyPut<EventInYourCityListController>(
        () => EventInYourCityListController());
    Get.lazyPut<JustForYouController>(() => JustForYouController());
    Get.lazyPut<TrendingListController>(() => TrendingListController());
    Get.lazyPut<OrganizerController>(() => OrganizerController());
    Get.lazyPut<HomeOrganizerController>(() => HomeOrganizerController());
    Get.lazyPut<EventsforOrganizerListController>(
        () => EventsforOrganizerListController());
    Get.lazyPut<OffersController>(() => OffersController());
Get.put<EventStateManager>(EventStateManager());
    Get.lazyPut<ReelsController>(() => ReelsController());
    Get.lazyPut<TypetoSetEventController>(() => TypetoSetEventController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}
