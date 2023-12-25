import 'package:evento/features/profile_pages/request_status/controller/request_status_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class RequestStatusBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestStatusController>(() =>RequestStatusController());
   
  }
}
