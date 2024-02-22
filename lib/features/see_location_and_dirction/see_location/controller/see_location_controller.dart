import '../../../../core/utils/helper/flutter_flow_google_map.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeeLocationController extends GetxController {
  late double latitude;
  late double longitude;
  late LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  late FlutterFlowMarker myMarker;

  @override
  void onInit() {
    latitude = Get.arguments[0];
    longitude = Get.arguments[1];
    googleMapsCenter = LatLng(latitude, longitude);
    myMarker = FlutterFlowMarker(
      'markerId1', // Unique ID for the marker
      LatLng(latitude, longitude), // Replace with your latitude and longitude
      (controller) async {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 14.0,
          ),
        ));
      },
    );
    super.onInit();
  }
}
