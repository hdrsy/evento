import 'package:evento/features/customize_event/date_time/controller/date_time_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class DateTimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DateTimeController>(() =>DateTimeController());
   
  }
}
