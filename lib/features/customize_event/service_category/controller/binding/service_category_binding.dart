import '../service_category_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class ServiceCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceCategoryController>(() =>ServiceCategoryController());
   
  }
}
