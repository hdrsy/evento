import '../page_controller.dart';
import '../steps_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class StepsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StepsController>(() => StepsController());
    Get.lazyPut<StepsPageController>(() => StepsPageController());
  
  }
}
