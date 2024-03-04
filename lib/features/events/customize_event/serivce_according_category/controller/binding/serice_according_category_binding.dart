import '../service_according_category_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class ServiceAccordingCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceAccordingCategoryController>(() =>ServiceAccordingCategoryController());
   
  }
}
