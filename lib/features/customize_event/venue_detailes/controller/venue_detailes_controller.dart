import 'package:evento/features/customize_event/serivce_according_category/model/service_according_category_model.dart';
import 'package:evento/features/customize_event/venue/model/venue_model.dart';
import 'package:get/get.dart';

class VenueDetailesController extends GetxController{
  late Venue venue;
  late bool isInCustomuzEvent;
 @override
  void onInit() {
    venue=Get.arguments[0];
    isInCustomuzEvent=Get.arguments[1];

    super.onInit();
  }


  
}