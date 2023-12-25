import 'package:evento/features/profile_pages/my_request/controller/my_request_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class MyRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRequestController>(() =>MyRequestController());
   
  }
}
