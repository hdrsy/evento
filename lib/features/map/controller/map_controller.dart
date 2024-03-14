import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_controller.dart';
import 'package:evento/core/server/filter.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';
import 'package:flutter/services.dart';
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
  final EventStateManager eventStateManager = Get.find();

  TextEditingController searchController = TextEditingController();
  final googleMapsController = Completer<GoogleMapController>();
  late FlutterFlowMarker myMarker;
  RxList<EventModel> searchResultSearch = <EventModel>[].obs;
  RxBool isSearchActive = false.obs;
  TextEditingController searchField = TextEditingController();
  late LatLng currentPosition;
  late BitmapDescriptor customIcon;
  bool isReady = false;

  @override
  void onInit() async {
    super.onInit();
    customIcon = await getCustomMarker();
    await getSuggestModels(); // Assumes this now properly initializes `myMarker`
    // Indicate that everything is ready
  }

  void onPressSearch(String query) {
    if (query.isEmpty) {
      isSearchActive.value = false;
      searchResultSearch.clear();
    } else {
      isSearchActive.value = true;
      searchResultSearch.assignAll(events
          .where((event) =>
              event.title.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }

  void onApplyFilters(Map<String, dynamic> data) async {
    isSearchActive.value = true;
    final d = await filter(data);
    print(d);
    Get.back();
    var eventModels =
        d.map((jsonItem) => EventModel.fromJson(jsonItem)).toList();
    searchResultSearch.addAll(eventModels.cast<EventModel>());
  }

  late LatLng? googleMapsCenter = const LatLng(13.106061, -59.613158);
  CarouselController? carouselController;

  late int carouselCurrentIndex;

  // State field(s) for PageView widget.
  // PageController? paggooeViewController1;
  getSuggestModels() async {
// final TrendingListController trendingListController=Get.find();
    final TrendingListController eventInYourCityListController =
        Get.put(TrendingListController());
    events.assignAll(eventInYourCityListController.itemList);

    currentPosition = LatLng(events[carouselCurrentIndex].venue!.lang,
        events[carouselCurrentIndex].venue!.long);
    googleMapsCenter = currentPosition;
    myMarker = FlutterFlowMarker(
      'markerId$carouselCurrentIndex', // Unique ID for the marker
      currentPosition, // Replace with your latitude and longitude
      icon: customIcon,

      (controller) async {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentPosition,
            zoom: 14.0,
          ),
        ));
      },
    );
    isReady = true;
    update();
  }

  void updateMarkerAndPosition(int carouselIndex) async {
    if (carouselIndex < 0 || carouselIndex >= events.length) return;

    currentPosition = LatLng(
        events[carouselIndex].venue!.lang, events[carouselIndex].venue!.long);
    googleMapsCenter = currentPosition;

    // Update marker
    myMarker = FlutterFlowMarker(
      'markerId$carouselIndex', // Unique ID for the marker
      currentPosition, // New position
      icon: customIcon,
      (controller) async {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentPosition,
            zoom: 14.0,
          ),
        ));
      },
    );

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
      eventStateManager.toggleFavorite(eventId);
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      events[modelIndex].isFollowedByAuthUser = false;
      eventStateManager.toggleFavorite(eventId);

      update();
    }
  }

  Future<BitmapDescriptor> getCustomMarker() async {
    final Uint8List markerIcon =
        await createCustomMarkerBitmap('assets/images/mapLogo.png');
    return BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<Uint8List> createCustomMarkerBitmap(String imagePath) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final image = await loadImage(imagePath); // Load image from path
    final imageSize = Offset(100.0, 120.0); // the marker size
    canvas.drawImageRect(
      image,
      Rect.fromLTRB(0.0, 0.0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromPoints(Offset(0.0, 0.0), imageSize),
      Paint(),
    );

    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(100, 120); //the marker size
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return bytes!.buffer.asUint8List();
  }

  Future<ui.Image> loadImage(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    final List<int> bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes as Uint8List);
    final ui.Image image = (await codec.getNextFrame()).image;

    return image;
  }
}
