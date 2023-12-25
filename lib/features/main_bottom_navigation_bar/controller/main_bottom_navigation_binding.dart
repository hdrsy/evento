import 'package:evento/features/customize_event/type_to_set_event/controller/type_to_set_event_controller.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/main_bottom_navigation_bar/controller/main_bottom_navigation_controller.dart';
import 'package:evento/features/profile_pages/profile/controller/profile_controller.dart';
import 'package:evento/features/reels/controller/reels_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
 // Import your controller

class MainBottomNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainBottomNavigationController>(() => MainBottomNavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoryListController>(() => CategoryListController());
    Get.lazyPut<FeaturedListController>(() => FeaturedListController());
    Get.lazyPut<EventInYourCityListController>(() => EventInYourCityListController());
    Get.lazyPut<JustForYouController>(() => JustForYouController());
    Get.lazyPut<TrendingListController>(() => TrendingListController());
    Get.lazyPut<OrganizerController>(() => OrganizerController());
  
    Get.lazyPut<ReelsController>(() => ReelsController());
    Get.lazyPut<TypetoSetEventController>(() => TypetoSetEventController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
