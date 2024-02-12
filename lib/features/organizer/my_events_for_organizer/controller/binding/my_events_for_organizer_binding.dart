import '../my_events_for_organizer_controller.dart';
import 'package:get/get.dart';
// Import your controller

class MyEventsForOrganizerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEventsForOrganizerController>(
        () => MyEventsForOrganizerController());
  }
}
