import 'package:evento/features/organizer/event_request_status_for_organizer/controller/event_request_status_for_organizer_controller.dart';

import 'package:get/get.dart';
// Import your controller

class EventRequestStatusForOrganizerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventRequestStatusForOrganizerController>(
        () => EventRequestStatusForOrganizerController());
  }
}
