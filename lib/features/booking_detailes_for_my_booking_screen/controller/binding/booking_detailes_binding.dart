import 'package:evento/features/booking_detailes/controller/booking_detailes_controller.dart';
import 'package:evento/features/booking_detailes_for_my_booking_screen/controller/booking_detailes_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class BookingDetailesForMyBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailesForMyBookingController>(() =>BookingDetailesForMyBookingController());
   
  }
}
