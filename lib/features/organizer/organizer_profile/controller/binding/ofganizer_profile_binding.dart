import 'package:evento/features/organizer/organizer_profile/controller/organizer_profile_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class OrganizerProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizerProfileController>(() =>OrganizerProfileController());
   
  }
}
