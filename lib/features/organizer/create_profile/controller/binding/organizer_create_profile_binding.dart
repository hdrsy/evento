import 'package:evento/features/organizer/create_profile/controller/oganizer_create_profile_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class OrganizerCreateProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizerCreateProfileController>(() =>OrganizerCreateProfileController());
   
  }
}
