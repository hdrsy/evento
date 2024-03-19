import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/services/location_service.dart';
import '../../../../main.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class Dd extends GetxController {
  Completer<GoogleMapController> controller = Completer();
  // late BitmapDescriptor sourceIcon;
  // late BitmapDescriptor destinationIcon;
  Set<Marker> markers = Set<Marker>();
  double pinPillPosition = 20;
  late LatLng currentLocation;
  late LatLng destinationLocation;
  bool userBadgeSelected = false;

  Set<Polyline> polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  @override
  void onInit() async {
    polylinePoints = PolylinePoints();
    // setSourceAndDestinationMarkerIcons();
    setInitialLocation();
    super.onInit();
  }

  void setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  CameraPosition initialCameraPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION);

  void showPinsOnMap() {
    markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: currentLocation,
        // icon: sourceIcon,
        infoWindow: InfoWindow(title: "sourcePin", snippet: "Sssssssss"),
        onTap: () {
          this.userBadgeSelected = true;
          update();
        }));

    markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position: destinationLocation,
        // icon: destinationIcon,
        onTap: () {
          this.pinPillPosition = PIN_VISIBLE_POSITION;
          update();
        }));
    update();
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAQqGaYBImwBfEwNfZEDkHDbOaJW7Pofrs",
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      polylines.add(Polyline(
          width: 10,
          polylineId: PolylineId('polyLine'),
          color: Color(0xFF08A5CB),
          points: polylineCoordinates));
      update();
    }
  }
}

class DirctionController extends GetxController {
  late double latitude;
  late double longitude;
  LatLng userLocation = LatLng(0, 0);
  late CameraPosition googleMapsCenter;
  late Marker myMarker; // Marker for destination
  Marker? userMarker; // Marker for user location
  final Set<Polyline> polylines = {};
  LocationService locationService = LocationService();
  // Completer<GoogleMapController> _controller = Completer();
  @override
  void onInit() async {
    super.onInit();
    latitude = Get.arguments[0];
    longitude = Get.arguments[1];
    await getUserLocation();
    googleMapsCenter = CameraPosition(target: LatLng(latitude, longitude));

    // Marker for destination
    myMarker = Marker(
      markerId: MarkerId('markerId1'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(),
    );

    // Start tracking user location
    drawRoute();
  }

  @override
  void onClose() {
    // Stop tracking when the controller is disposed
    // locationService.stopTracking();
    super.onClose();
  }

  void updateMapView() async {
    if (userMarker != null) {
      // LatLngBounds bounds =
      //     _boundsFromLatLngList([userMarker!.position, myMarker.position]);
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
    Position p = await locationService.getCurrentLocation();

    // Update user location marker
    updateUserLocationMarker(p.latitude, p.longitude);
    userLocation = LatLng(p.latitude, p.longitude);
    // Additional handling can be added here
    // For example, updating the map view or calculating distance
  }

  void drawRoute() async {
    var currentLocation = await locationService.getCurrentLocation();
    LatLng startLocation =
        LatLng(currentLocation.latitude, currentLocation.longitude);
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
    userMarker = Marker(
      markerId: MarkerId('markerId2'), // Unique ID for the user location marker
      position: LatLng(latitude, longitude),
    );
    updateMapView();
    update(); // Update GetX state to refresh the UI
  }
}
