import 'package:evento/features/organizer/my_events_for_organizer/model/my_events_for_organizer_model.dart';

import 'package:get/get.dart';

class EventRequestStatusForOrganizerController extends GetxController {
  late MyEventsForOrganizerModel myRequestModel;
  @override
  void onInit() {
    myRequestModel = Get.arguments;
    super.onInit();
  }
}
