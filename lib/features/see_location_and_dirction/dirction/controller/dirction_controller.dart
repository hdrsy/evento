import 'package:evento/core/utils/helper/flutter_flow_google_map.dart';
import 'package:evento/core/utils/services/location_service.dart';
import 'package:evento/main.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DirctionController extends GetxController {
  late double latitude;
  late double longitude;
  late LatLng googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  late FlutterFlowMarker myMarker; // Marker for destination
  FlutterFlowMarker? userMarker; // Marker for user location
final Set<Polyline> polylines = {};
  LocationService locationService = LocationService();

  @override
  void onInit() async{
    super.onInit();
    latitude = Get.arguments[0];
    longitude = Get.arguments[1];
    googleMapsCenter = LatLng(latitude, longitude);

    // Marker for destination
    myMarker = FlutterFlowMarker(
      'markerId1',
      googleMapsCenter,
    );

    // Start tracking user location
    await getUserLocation();
    drawRoute();
  }

  @override
  void onClose() {
    // Stop tracking when the controller is disposed
    locationService.stopTracking();
    super.onClose();
  }

   getUserLocation() async {
    // Start tracking user location
    locationService.startTracking();

    // Listen to location updates
    locationService.location.onLocationChanged.listen((LocationData currentLocation) {
      // Update user location marker
      updateUserLocationMarker(currentLocation.latitude!, currentLocation.longitude!);

      // Additional handling can be added here
      // For example, updating the map view or calculating distance
    });
  }
void drawRoute() async {
    var currentLocation = await locationService.getCurrentLocation();
    LatLng startLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    LatLng destinationLocation = LatLng(latitude, longitude);

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
"AIzaSyDcrPKoj_FUdONJKoZ617uewYFkzWMnJR4", // Your API Key
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      polylines.clear(); // Clear existing polylines

      // Convert the result to a list of LatLng
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      Polyline polyline = Polyline(
        polylineId: PolylineId('route'),
        color: customColors.primary,
        points: polylineCoordinates,
        width: 5,
      );

      polylines.add(polyline);
      update(); // Notify listeners for state update
    }
  }
  void updateUserLocationMarker(double latitude, double longitude) {
    userMarker = FlutterFlowMarker(
      'markerId2', // Unique ID for the user location marker
      LatLng(latitude, longitude),
    );

    update(); // Update GetX state to refresh the UI
  }
}
