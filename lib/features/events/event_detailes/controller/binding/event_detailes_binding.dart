import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class EventDetailesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventDetailesController>(() =>EventDetailesController());
  }
}
