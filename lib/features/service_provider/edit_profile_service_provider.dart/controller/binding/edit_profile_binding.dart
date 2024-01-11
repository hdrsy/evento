import 'package:evento/features/service_provider/edit_profile_service_provider.dart/controller/edit_profile_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class EditProfileServiceProviderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileServiceProviderController>(() =>EditProfileServiceProviderController());
   
  }
}
