import 'package:evento/features/organizer/create_profile/controller/oganizer_create_profile_controller.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/controller/service_provider_create_profile_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class ServiceProviderCreateProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceProviderCreateProfileController>(() =>ServiceProviderCreateProfileController());
   
  }
}
