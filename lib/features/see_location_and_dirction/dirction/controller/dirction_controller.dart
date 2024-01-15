import '../../../../core/utils/helper/flutter_flow_google_map.dart';
import '../../../../core/utils/services/location_service.dart';
import '../../../../main.dart';
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
      (controller) async {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 14.0,
          ),
        ));
      },
    
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
  void updateMapView() async {
    final GoogleMapController controller = await googleMapsController.future;
    
    if (userMarker != null && myMarker != null) {
      LatLngBounds bounds = _boundsFromLatLngList([userMarker!.location, myMarker.location]);
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }
  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(southwest: LatLng(x0!, y0!), northeast: LatLng(x1!, y1!));
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
"AIzaSyAQqGaYBImwBfEwNfZEDkHDbOaJW7Pofrs", // Your API Key
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
      (controller) async {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 14.0,
          ),
        ));
      },
    
    );
 updateMapView(); 
    update(); // Update GetX state to refresh the UI
  }
}
