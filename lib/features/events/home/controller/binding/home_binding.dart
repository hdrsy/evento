import '../home_controller.dart';
import 'package:get/get.dart';
// Import your controller

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoryListController>(() => CategoryListController());
  }
}
