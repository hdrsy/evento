import '../date_time_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class DateTimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DateTimeController>(() =>DateTimeController());
   
  }
}
