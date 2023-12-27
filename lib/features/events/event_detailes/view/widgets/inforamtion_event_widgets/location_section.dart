import 'package:evento/core/utils/helper/flutter_flow_google_map.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget buildLocationSection(BuildContext context) {
  final EventDetailesController eventDetailesController=Get.find();
  LatLng googleMapsCenter=LatLng(eventDetailesController.eventDetailsModel.venue.latitude, eventDetailesController.eventDetailsModel.venue.longitude);
  final googleMapsController = Completer<GoogleMapController>();
  return
  
        InkWell(
        onTap: (){
           Get.toNamed('/SeeLocation',arguments: [eventDetailesController.eventDetailsModel.venue.latitude,eventDetailesController.eventDetailsModel.venue.longitude]);
        
        },
        child:  Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
               "Location" ,
              style: customTextStyle.bodySmall.override(
                fontFamily: 'Open Sans',
                color: customColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
          ),
          child: FlutterFlowGoogleMap(
            controller: googleMapsController,
            onCameraIdle: (latLng) =>
                googleMapsCenter = latLng,
            initialLocation: googleMapsCenter 
                ,
            markerColor: GoogleMarkerColor.violet,
            mapType: MapType.normal,
            style: GoogleMapStyle.standard,
            initialZoom: 14,
            allowInteraction: true,
            allowZoom: true,
            showZoomControls: true,
            showLocation: true,
            showCompass: false,
            showMapToolbar: false,
            showTraffic: false,
            centerMapOnMarkerTap: true,
          ),
        ),
      
    ],
  ));
}
