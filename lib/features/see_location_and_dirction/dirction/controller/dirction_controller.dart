import 'dart:async';

import 'package:evento/core/utils/services/snackbar_manager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/services/location_service.dart';
import '../../../../main.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 14;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class DirctionController extends GetxController {
  late double latitude;
  late double longitude;
  LatLng userLocation = LatLng(0, 0);
  late CameraPosition googleMapsCenter;
  late Marker myMarker; // Marker for destination
  Marker? userMarker; // Marker for user location
  final Set<Polyline> polylines = {};
  LocationService locationService = LocationService();
  Completer<GoogleMapController> controller = Completer();
  GoogleMapController? googleMapController;
  @override
  void onInit() async {
    super.onInit();
    latitude = Get.arguments[0];
    longitude = Get.arguments[1];
    googleMapsCenter =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 12);

    // Marker for destination
    myMarker = Marker(
      markerId: MarkerId('markerId1'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(),
    );

    await getUserLocation();
    // Start tracking user location
    // drawRoute();
  }

  @override
  void onClose() {
    // Stop tracking when the controller is disposed
    // locationService.stopTracking();
    super.onClose();
  }

  void updateMapView() async {
    if (userMarker != null) {
      LatLngBounds bounds =
          boundsFromLatLngList([userMarker!.position, myMarker.position]);
    }
  }

  void adjustCamera(List<LatLng> polylineCoordinates) async {
    if (polylineCoordinates.isNotEmpty) {
      LatLngBounds bounds = boundsFromLatLngList(polylineCoordinates);
      // GoogleMapController controller = await _controller.future;
      googleMapController!.animateCamera(CameraUpdate.newLatLngBounds(
          bounds, 100)); // Adjust the padding as needed
    }
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
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
    return LatLngBounds(
        southwest: LatLng(x0!, y0!), northeast: LatLng(x1!, y1!));
  }

  getUserLocation() async {
    // Start tracking user location
    // locationService.startTracking();

    // Listen to location updates
    Position p = await LocationService.getCurrentLocation();

    // Update user location marker
    updateUserLocationMarker(p.latitude, p.longitude);
    userLocation = LatLng(p.latitude, p.longitude);
    // Additional handling can be added here
    // For example, updating the map view or calculating distance
  }

  void drawRoute() async {
    try {
      var currentLocation = await LocationService.getCurrentLocation();
      LatLng startLocation =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      LatLng destinationLocation = LatLng(latitude, longitude);

      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAQqGaYBImwBfEwNfZEDkHDbOaJW7Pofrs", // Your API Key
        PointLatLng(startLocation.latitude, startLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude),
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
        // updateMapView();
        adjustCamera(polylineCoordinates);
        update(); // Notify listeners for state update
      }
    } catch (e) {
      SnackbarManager.showSnackbar(
        "Direction",
        "Something wrong when get direction",
        icon: Icon(Icons.directions, color: customColors.primaryText),
        backgroundColor: customColors.primaryBackground,
      );
    }
  }

  void updateUserLocationMarker(double latitude, double longitude) {
    userMarker = Marker(
      markerId: MarkerId('markerId2'), // Unique ID for the user location marker
      position: LatLng(latitude, longitude),
    );
    updateMapView();
    update(); // Update GetX state to refresh the UI
  }
}
