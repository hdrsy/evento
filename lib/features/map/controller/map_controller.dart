import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import '../../../core/server/follow_unfollow_event_api.dart';
import '../../../core/server/server_config.dart';
import '../../../core/utils/helper/flutter_flow_google_map.dart';
import '../../events/home/controller/home_controller.dart';
import '../../events/home/model/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  List<EventModel> events = [];
TextEditingController searchController=TextEditingController();
  final googleMapsController = Completer<GoogleMapController>();
  late FlutterFlowMarker myMarker;
  RxList<EventModel> searchResultSearch=<EventModel>[].obs;
   RxBool isSearchActive=false.obs;
  
late LatLng currentPosition;
  @override
  void onInit() async {
    await getSuggestModels();
    // TODO: implement on
    // Init
    // googleMapsCenter
   
    super.onInit();
  }

  late LatLng? googleMapsCenter = const LatLng(13.106061, -59.613158);
  CarouselController? carouselController;

  late int carouselCurrentIndex;

  // State field(s) for PageView widget.
  // PageController? paggooeViewController1;
  getSuggestModels() {
// final TrendingListController trendingListController=Get.find();
    final TrendingListController eventInYourCityListController = Get.put(TrendingListController());
    events.assignAll(eventInYourCityListController.itemList);
    print(events.length);
     carouselCurrentIndex = 0;
    print(events.length);
    print(events[0]);
    currentPosition=LatLng(events[carouselCurrentIndex].venue!.lang,
        events[carouselCurrentIndex].venue!.long);
    googleMapsCenter = currentPosition;

    myMarker = FlutterFlowMarker(
      'markerId$carouselCurrentIndex', // Unique ID for the marker
      currentPosition, // Replace with your latitude and longitude
      (controller) async {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentPosition,
            zoom: 14.0,
          ),
        ));
      },
    );

  }
  void updateMarkerAndPosition(int carouselIndex) {
  if (carouselIndex < 0 || carouselIndex >= events.length) return;

  currentPosition = LatLng(events[carouselIndex].venue!.lang,
                           events[carouselIndex].venue!.long);
  googleMapsCenter = currentPosition;

  // Update marker
  myMarker = FlutterFlowMarker(
    'markerId$carouselIndex', // Unique ID for the marker
    currentPosition, // New position
    (controller) async {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentPosition,
          zoom: 14.0,
        ),
      ));
    },
  );
  print("fffffffffffffffffffff");
  print("fffffffffffffffffffff");
  print(myMarker.markerId);
  print("fffffffffffffffffffff");

  // Update camera position
  googleMapsController.future.then((controller) {
    controller.animateCamera(CameraUpdate.newLatLng(currentPosition));
  });

  update(); // Call update to refresh the UI if needed
}
followOrUnFollowEvent(int eventId, int modelIndex) async {
    late String isDoneSuccefully;
    if (events[modelIndex].isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      events[modelIndex].isFollowedByAuthUser = true;
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      events[modelIndex].isFollowedByAuthUser = false;

      update();
    }
   }

    void onPressSearch(String query) {
  if (query.isEmpty) {
    isSearchActive.value = false;
    searchResultSearch.clear();
  } else {
    isSearchActive.value = true;
    searchResultSearch.assignAll(
      events.where(
        (event) => event.title.toLowerCase().contains(query.toLowerCase())
      ).toList()
    );
  }
}


}
