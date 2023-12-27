import 'package:evento/features/customize_event/venue/controller/venue_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class VenueBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueController>(() => VenueController());
  }
}
