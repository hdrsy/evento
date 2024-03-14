import 'package:evento/main.dart';

import '../../../../core/utils/helper/flutter_flow_google_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/map_controller.dart';

class MapWidget extends StatelessWidget {
  MapWidget({super.key});
  final MapController mapController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(builder: (controller) {
      return !mapController.isReady
          ? SizedBox()
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FlutterFlowGoogleMap(
                controller: mapController.googleMapsController,
                onCameraIdle: (latLng) => mapController.googleMapsCenter,
                initialLocation: mapController.googleMapsCenter,
                // markerColor: GoogleMarkerColor.violet,
                markers: [mapController.myMarker],
                mapType: MapType.normal,
                style: GoogleMapStyle.standard,
                initialZoom: 14,
                allowInteraction: true,
                allowZoom: true,
                showZoomControls: false,
                showLocation: true,
                showCompass: false,
                showMapToolbar: false,
                showTraffic: false,
                centerMapOnMarkerTap: true,
              ),
            );
    });
  }
}
