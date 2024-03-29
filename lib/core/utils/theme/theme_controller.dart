import 'package:evento/features/main_bottom_navigation_bar/controller/main_bottom_navigation_controller.dart';

import 'app_theme.dart';
import '../../../main.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  late RxBool theThemeIsDark = false.obs;

  @override
  void onInit() async {
    theThemeIsDark.value =
        await prefService.readString('theme') == 'dark' ? true : false;

    super.onInit();
  }

  changeTheme() async {
    if (theThemeIsDark.value) {
      await prefService.createString("theme", "light");
      theThemeIsDark.value = false;
      Get.changeTheme(AppTheme.light);
    } else if (!theThemeIsDark.value) {
      await prefService.createString("theme", "dark");
      theThemeIsDark.value = true;
      Get.changeTheme(AppTheme.dark);
    }

    Future.delayed(const Duration(milliseconds: 190)).then((value) {
      MainBottomNavigationController mainBottomNavigationController =
          Get.find();
      mainBottomNavigationController.changePage(0);
    });
    update();
  }
}
