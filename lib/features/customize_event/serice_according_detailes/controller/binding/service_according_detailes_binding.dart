import '../service_according_detailes_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class ServiceAccordingDetailesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceAccordingDetailesController>(() =>ServiceAccordingDetailesController());
   
  }
}
