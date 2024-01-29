import '../../venue/model/venue_model.dart';
import 'package:get/get.dart';

class VenueDetailesController extends GetxController {
  late Venue venue;
  late bool isInCustomuzEvent;
  @override
  void onInit() {
    venue = Get.arguments[0];
    isInCustomuzEvent = Get.arguments[1];

    super.onInit();
  }
}
