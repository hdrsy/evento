import '../organization_profile_controller.dart';
import 'package:get/get.dart';
// Import your controller

class OrganizationProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizationProfileController>(
        () => OrganizationProfileController());
  }
}
