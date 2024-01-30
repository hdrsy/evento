import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/services/location_service.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/controller/service_provider_create_profile_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final LocationService _locationService = LocationService();
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;
  Set<Marker> _markers = {};
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
    searchController.addListener(_onSearchChanged);
  }
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        _searchPlaces(searchController.text);
        // onPressSearch(searchField.text);
        print("inisde the timer ");
      } else {
        // Optionally handle empty search field case
        // _fetchData("");
      }
    });
  }
  Future<List<Place>> _searchPlaces(String searchTerm) async {
    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyAQqGaYBImwBfEwNfZEDkHDbOaJW7Pofrs&input=$searchTerm';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      // Parse the result to get the places
      // ...
      print("result $result");
      List<Place> place=[];
      return place; // List of Place objects
    } else {
      throw Exception('Failed to load places');
    }
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
      body: Stack(
        children:[ GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(0.0, 0.0), // Default initial position
            zoom: 2.0,
          ),
          onTap: _onMapTap,
          markers: _markers,
        ),
          Positioned(
            top: 10, // Adjust the positioning as needed
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Location',
                  border: InputBorder.none,
                ),
                // onChanged: _onSearchChanged,
              ),
            ),
          ),
        ]
      ),
    );
  }
}
class Place {
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Place({required this.name, required this.address, required this.latitude, required this.longitude});

  factory Place.fromJson(Map<String, dynamic> json) {
    // Assuming the JSON structure fits these fields; adjust as per actual API response
    return Place(
      name: json['name'],
      address: json['formatted_address'],
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
    );
  }
}
