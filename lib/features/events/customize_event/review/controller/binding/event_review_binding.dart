import '../event_review_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class EventReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventReviewController>(() =>EventReviewController());
   
  }
}
