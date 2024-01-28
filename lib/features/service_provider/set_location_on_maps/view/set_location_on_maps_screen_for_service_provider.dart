import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/services/location_service.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/controller/service_provider_create_profile_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final LocationService _locationService = LocationService();
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  _getUserLocation() async {
    try {
      LocationData currentLocation =
          await _locationService.getCurrentLocation();

      _moveCameraTo(LatLng(
          currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0));
    } catch (e) {
      // Handle the exception (e.g., show an error message)
      print('Error getting location: $e');
    }
  }

  void _moveCameraTo(LatLng position) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15.0),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _markers.clear(); // Clear existing markers
      _markers.add(
        Marker(
          markerId: MarkerId('selectedLoc'),
          position: location,
          infoWindow: InfoWindow(title: 'Selected Location'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Set Your Location"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_selectedLocation != null) {
                ServiceProviderCreateProfileController controller = Get.find();
                controller.locationData = _selectedLocation;
                Get.back();
                // Navigator.pop(context, _selectedLocation);
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0), // Default initial position
          zoom: 2.0,
        ),
        onTap: _onMapTap,
        markers: _markers,
      ),
    );
  }
}
