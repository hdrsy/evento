import 'dart:async';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_controller.dart';
import 'package:evento/core/server/filter.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';
import 'package:evento/features/search/model/search_model.dart';
import 'package:evento/main.dart';
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
  final EventStateManager eventStateManager = Get.find();

  TextEditingController searchController = TextEditingController();
  final googleMapsController = Completer<GoogleMapController>();
  late FlutterFlowMarker myMarker;
  RxBool isSearchActive = false.obs;
  TextEditingController searchField = TextEditingController();
  late LatLng currentPosition;
  late BitmapDescriptor customIcon;
  bool isReady = false;
  var searchResultSearch = <SearchModel>[].obs;
  Timer? _debounce;

  @override
  void onInit() async {
    super.onInit();
    customIcon = await getCustomMarker();
    myMarker = FlutterFlowMarker(
      'markerId-1', // Unique ID for the marker
      LatLng(0, 0), // Replace with your latitude and longitude
      icon: customIcon,

      (controller) async {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(0, 0),
            zoom: 14.0,
          ),
        ));
      },
    );

    _fetchData(""); // Fetch initial data with empty query
    searchField.addListener(_onSearchChanged);

    await getSuggestModels(); // Assumes this now properly initializes `myMarker`

    // Indicate that everything is ready
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchField.text.isNotEmpty) {
        onPressSearch(searchField.text);
      } else {
        // Optionally handle empty search field case
        _fetchData("");
        isSearchActive.value = false;
      }
    });
  }

  void onApplyFilters(Map<String, dynamic> data) async {
    final d = await filter(data);
    Get.back();
    var eventModels =
        d.map((jsonItem) => EventModel.fromJson(jsonItem)).toList();
    isSearchActive.value = true;
    searchResultSearch.addAll(eventModels.cast<EventModel>());
    update();
  }

  void _fetchData(String query) async {
    try {
      String token = await prefService.readString("token");
      var response = await ApiHelper.makeRequest(
          targetRout: isGuset
              ? ServerConstApis.eventSearchforGuest
              : ServerConstApis.eventSearch,
          method: "post",
          data: {"Search": query},
          token: token);

      response.fold(
        (error) => _handleError(error),
        (result) => _handleSuccess(result),
      );
    } catch (e) {
      // isError.value = true;
    }
  }

  void _handleError(ErrorResponse error) {
    // isError.value = true;
    // Handle your error, maybe show a snackbar or log it
    // Get.snackbar("Error", error.message); // Example
  }

  void _handleSuccess(Map<String, dynamic> data) {
    var results = (data['result'] as List)
        .map((jsonItem) => SearchModel.fromJson(jsonItem))
        .toList();
    update();
    _updateSearchResults(results);
  }

  void _updateSearchResults(List<SearchModel> results) {
    searchResultSearch.assignAll(results);
    getSuggestModels();
    update();
  }

  void onPressSearch(String query) {
    isSearchActive.value = query.isNotEmpty;
    if (isSearchActive.isTrue) {
      _fetchData(query);
    } else {
      _fetchData("");

      update();
      // _updateSearchResults([]);
    }
  }

  late LatLng? googleMapsCenter = const LatLng(13.106061, -59.613158);
  CarouselController? carouselController;

  late int carouselCurrentIndex;

  // State field(s) for PageView widget.
  // PageController? paggooeViewController1;
  getSuggestModels() async {
    if (searchResultSearch.isEmpty) {
      isReady = true;
      update();
      return;
    } else {
      // carouselCurrentIndex = 0;
    }
    print("sssssssss startMArker");
    currentPosition = LatLng(
        searchResultSearch[carouselCurrentIndex].venue.latitude,
        searchResultSearch[carouselCurrentIndex].venue.longitude);
    googleMapsCenter = currentPosition;
    print("sssssssss ${currentPosition.latitude}");
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
        update();
      },
    );
    print("sssssssss ${myMarker}");
    update();
    isReady = true;
  }

  void updateMarkerAndPosition(int carouselIndex) async {
    if (carouselIndex < 0 || carouselIndex >= searchResultSearch.length) return;

    currentPosition = LatLng(searchResultSearch[carouselIndex].venue.latitude,
        searchResultSearch[carouselIndex].venue.longitude);
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
    if (searchResultSearch[modelIndex].isFollowedByAuthUser) {
      isDoneSuccefully = await followUnFollowEvent(
          "${ServerConstApis.unFollowEvent}/$eventId");
    } else {
      isDoneSuccefully =
          await followUnFollowEvent("${ServerConstApis.followEvent}/$eventId");
    }
    if (isDoneSuccefully == "followed successfully") {
      searchResultSearch[modelIndex].isFollowedByAuthUser = true;
      eventStateManager.toggleFavorite(eventId);
      update();
    } else if (isDoneSuccefully == "removed successfully") {
      searchResultSearch[modelIndex].isFollowedByAuthUser = false;
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
