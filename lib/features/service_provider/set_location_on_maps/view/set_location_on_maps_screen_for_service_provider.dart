import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/services/location_service.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/service_provider/service_provider_create_profile/controller/service_provider_create_profile_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:location/location.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final LocationService _locationService = LocationService();
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;
  Set<Marker> _markers = {};
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  _getUserLocation() async {
    try {
      Position currentLocation = await _locationService.getCurrentLocation();

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
          markerId: const MarkerId('selectedLoc'),
          position: location,
          infoWindow: const InfoWindow(title: 'Selected Location'),
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
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_selectedLocation != null) {
                ServiceProviderCreateProfileController controller = Get.find();

                controller.locationData = _selectedLocation;
                controller.update();
                Get.back();
                // Navigator.pop(context, _selectedLocation);
              }
            },
          ),
        ],
      ),
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0.0, 0.0), // Default initial position
            zoom: 2.0,
          ),
          onTap: _onMapTap,
          markers: _markers,
        ),
        Positioned(
            top: 10, left: 5, right: 5, child: placesAutoCompleteTextField())
      ]),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,

      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: "AIzaSyAQqGaYBImwBfEwNfZEDkHDbOaJW7Pofrs",
        inputDecoration: InputDecoration(
            hintText: "Search your location",
            hintStyle: customTextStyle.bodyMedium.override(
              fontFamily: 'Open Sans',
              color: customColors.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelStyle: customTextStyle.bodyMedium),

        debounceTime: 400,
        countries: ["sy"],
        isLatLngRequired: false,
        getPlaceDetailWithLatLng: (Prediction prediction) {},

        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
          if (prediction.lat != null) {
            _onMapTap(LatLng(
                double.parse(prediction.lat!), double.parse(prediction.lng!)));
          }
        },
        seperatedBuilder: const Divider(),
        containerHorizontalPadding: 10,

        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 7,
                ),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }
}
