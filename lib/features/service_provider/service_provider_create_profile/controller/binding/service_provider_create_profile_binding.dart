import '../service_provider_create_profile_controller.dart';
import 'package:get/get.dart';
// Import your controller

class ServiceProviderCreateProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceProviderCreateProfileController>(
        () => ServiceProviderCreateProfileController());
  }
}
