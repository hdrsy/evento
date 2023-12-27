import 'package:evento/features/customize_event/serice_according_detailes/controller/service_according_detailes_controller.dart';
import 'package:evento/features/customize_event/venue_detailes/controller/venue_detailes_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class VenueDetailesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueDetailesController>(() =>VenueDetailesController());
   
  }
}
