import 'package:evento/core/shared/widgets/guest/guest_page.dart';
import 'package:evento/features/events/customize_event/type_to_set_event/controller/type_to_set_event_controller.dart';
import 'package:evento/features/events/customize_event/type_to_set_event/view/type_to_set_event_screen.dart';
import 'package:evento/features/events/home/view/home_screen.dart';
import 'package:evento/features/profile_pages/profile/view/profile_screen.dart';
import 'package:evento/features/reels/view/reels_screen.dart';
import 'package:evento/features/search/controller/search_controller.dart';
import 'package:evento/features/search/view/search_screen.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavigationController extends GetxController {
  @override
  void onInit() async {
    // await startTracking();

    super.onInit();
  }

  RxInt selectedPage = 0.obs;
  final List<Widget?> lazyLoadedScreens = [
    null,
    null,
    null,
    null,
    isGuset ? const GuestWidget() : ProfileScreen()
  ]; // Assuming 5 tabs

  Widget getScreen(int index) {
    if (lazyLoadedScreens[index] == null) {
      // Initialize the screen if it hasn't been initialized yet
      switch (index) {
        case 0:
          lazyLoadedScreens[index] = HomeScreen();
          break;
        case 1:
          lazyLoadedScreens[index] = SearchScreen();
          break;
        case 2:
          lazyLoadedScreens[index] = ReelsScreen();
          break;
        case 3:
          lazyLoadedScreens[index] =
              isGuset ? const GuestWidget() : TypeToSetEventScreen();
          break;
        case 4:
          lazyLoadedScreens[index] =
              isGuset ? const GuestWidget() : ProfileScreen();
          break;
      }
    }
    return lazyLoadedScreens[index]!;
  }

  changePage(int index) {
    if (selectedPage.value == 1 && index != 1) {
      Get.find<SearchPageController>().resetController();
    } else if (selectedPage.value == 3 && index != 3) {
      Get.find<TypetoSetEventController>().resetController();
    }
    selectedPage.value = index;
  }
}
