import '../my_request_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class MyRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRequestController>(() =>MyRequestController());
   
  }
}
