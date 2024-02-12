import '../booking_detailes_in_event_for_organizer_controller.dart';
import 'package:get/get.dart';
// Import your controller

class BookingDetailesInEventForOrganizerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailesInEventForOrganizerController>(
        () => BookingDetailesInEventForOrganizerController());
  }
}
