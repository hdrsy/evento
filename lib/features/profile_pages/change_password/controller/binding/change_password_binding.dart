import '../change_password_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() =>ChangePasswordController());
   
  }
}
