import '../booking_detailes_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class BookingDetailesForMyBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailesForMyBookingController>(() =>BookingDetailesForMyBookingController());
   
  }
}
