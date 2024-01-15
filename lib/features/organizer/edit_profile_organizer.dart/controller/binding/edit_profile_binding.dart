import '../edit_profile_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class EditProfileOrganizerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileOrganizerController>(() =>EditProfileOrganizerController());
   
  }
}
