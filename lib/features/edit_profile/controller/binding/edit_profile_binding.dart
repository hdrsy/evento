import 'package:evento/features/edit_profile/controller/edit_profile_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() =>EditProfileController());
   
  }
}
