import 'dart:async';

import 'package:geolocator/geolocator.dart';
StreamSubscription<Position>? positionStream;
class LocationService {
  // Get the current location of the user
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 
    return await Geolocator.getCurrentPosition();
    
  }

  // Calculate the distance between the user's current location and a given location
  Future<String> calculateDistance(double latitude, double longitude) async {
    try {
      final LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);
      Position userLocation = await getCurrentLocation();
 positionStream= Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position? position) {
        print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
        userLocation=position!;
    });

      double distanceInMeters = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        latitude,
        longitude,
      );

      // Convert to a readable format (km or m)
      return formatDistance(distanceInMeters);
    } catch (e) {
      return Future.error('Error: ${e.toString()}');
    }
  }

  String formatDistance(double distance) {
    if (distance < 1000) {
      return "${distance.toStringAsFixed(0)} m";
    } else {
      return "${(distance / 1000).toStringAsFixed(1)} km";
    }
  }
}
