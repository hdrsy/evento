
import 'package:evento/features/customize_event/type_to_set_event/view/type_to_set_event_screen.dart';
import 'package:evento/features/events/home/view/home_screen.dart';
import 'package:evento/features/profile_pages/profile/view/profile_screen.dart';
import 'package:evento/features/reels/view/reels_screen.dart';
import 'package:evento/features/search/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavigationController extends GetxController {
  late List<Widget> screens;
  @override
  void onInit() {
    screens = [
      HomeScreen(),
      const SearchScreen(),
      ReelsScreen(),
       TypeToSetEventScreen(),
       ProfileScreen()
    ];
   
    super.onInit();
  }

  RxInt selectedPage = 0.obs;
  changePage(int index) {
    selectedPage.value = index;
  }
}
