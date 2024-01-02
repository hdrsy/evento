import 'package:evento/features/customize_event/serivce_according_category/model/service_according_category_model.dart';
import 'package:evento/features/customize_event/venue/model/venue_model.dart';
import 'package:get/get.dart';

class VenueDetailesController extends GetxController{
  late Venue venue;
 @override
  void onInit() {
    venue=Get.arguments;
    print(venue.venueAlbums.length);
    print(venue.venueAlbums[0].images.length);
    super.onInit();
  }
}