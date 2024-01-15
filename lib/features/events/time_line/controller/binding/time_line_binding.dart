import '../time_line_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class TimeLineBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeLineController>(() =>TimeLineController());
  }
}
