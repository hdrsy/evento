import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:location/location.dart';

class LocationService {
  StreamSubscription<LocationData>? _locationSubscription;
  Location location = new Location();

  // Initialize location tracking
  void startTracking() {
    _locationSubscription = location.onLocationChanged.listen((LocationData currentLocation) {
      // Handle location update
      print("Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}");
      // Additional handling can be added here
    });
  }

  // Stop location tracking
  void stopTracking() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
      _locationSubscription = null;
    }
  }

  // Get the current location of the user
  Future<LocationData> getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    if (_permissionGranted == PermissionStatus.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await location.getLocation();
  }

  // Calculate the distance between the user's current location and a given location
  Future<String> calculateDistance(double latitude, double longitude) async {
    try {
      LocationData userLocation = await getCurrentLocation();

      double distanceInMeters = _calculateDistanceInMeters(
        userLocation.latitude!,
        userLocation.longitude!,
        latitude,
        longitude,
      );

      // Convert to a readable format (km or m)
      return _formatDistance(distanceInMeters);
    } catch (e) {
      return Future.error('Error: ${e.toString()}');
    }
  }

  double _calculateDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Pi / 180
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a)) * 1000; // 2 * R; R = 6371 km
  }

  String _formatDistance(double distance) {
    if (distance < 1000) {
      return "${distance.toStringAsFixed(0)} m";
    } else {
      return "${(distance / 1000).toStringAsFixed(1)} km";
    }
  }
}
