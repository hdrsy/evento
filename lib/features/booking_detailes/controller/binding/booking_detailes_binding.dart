import 'package:evento/features/booking_detailes/controller/booking_detailes_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class BookingDetailesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailesController>(() =>BookingDetailesController());
   
  }
}
