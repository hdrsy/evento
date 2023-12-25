import 'package:evento/features/profile_pages/change_password/controller/change_password_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() =>ChangePasswordController());
   
  }
}
