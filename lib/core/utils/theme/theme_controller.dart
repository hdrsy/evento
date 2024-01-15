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
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
      Get.offAllNamed('/home');
    });
    update();
  }
}
