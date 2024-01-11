import 'package:evento/features/organizer/edit_profile_organizer.dart/controller/edit_profile_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class EditProfileOrganizerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileOrganizerController>(() =>EditProfileOrganizerController());
   
  }
}
