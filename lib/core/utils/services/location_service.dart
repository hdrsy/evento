import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:evento/main.dart';
import 'package:geolocator/geolocator.dart';

Position? userLocation;
StreamSubscription<Position>? positionStream;

class LocationService {
  // Get the current location of the user
  static Future<Position> getCurrentLocation() async {
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return await Geolocator.getCurrentPosition();
  }

  // Calculate the distance between the user's current location and a given location
  static Future<String> calculateDistance(
      double latitude, double longitude) async {
    try {
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      userLocation =
          userLocation == null ? await getCurrentLocation() : userLocation;
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
        userLocation = position!;
      });

      double distanceInMeters = Geolocator.distanceBetween(
        userLocation!.latitude,
        userLocation!.longitude,
        latitude,
        longitude,
      );

      // Convert to a readable format (km or m)
      return formatDistance(distanceInMeters);
    } catch (e) {
      return Future.error('Error: ${e.toString()}');
    }
  }

  static String formatDistance(double distance) {
    if (distance < 1000) {
      return "${distance.toStringAsFixed(0)} ${tr("m")}";
    } else {
      return "${(distance / 1000).toStringAsFixed(1)} ${tr("km")}";
    }
  }
}
