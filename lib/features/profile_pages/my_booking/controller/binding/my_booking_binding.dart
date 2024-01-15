import '../my_booking_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class MyBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBookingController>(() =>MyBookingController());
   
  }
}
