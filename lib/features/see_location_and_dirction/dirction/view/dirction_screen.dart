import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_google_map.dart';
import 'package:evento/features/see_location_and_dirction/dirction/controller/dirction_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirctionScreen extends StatelessWidget {
   DirctionScreen({super.key});
final DirctionController dirctionController=Get.put(DirctionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Location",
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: GetBuilder<DirctionController>(
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            height:screenHeight*0.8 ,
            child:  FlutterFlowGoogleMap(
              polylines: dirctionController.polylines,
    controller: dirctionController.googleMapsController,
    onCameraIdle: (latLng) => dirctionController.googleMapsCenter = latLng,
    initialLocation: dirctionController.googleMapsCenter ,
            
markers: [
    if (dirctionController.userMarker != null) dirctionController.userMarker!,
    dirctionController.myMarker,
  ],
    markerColor: GoogleMarkerColor.red,
    mapType: MapType.normal,
    style: GoogleMapStyle.standard,
    initialZoom: 18,
    allowInteraction: true,
    allowZoom: true,
    showZoomControls: true,
    showLocation: true,
    showCompass: true,
    showMapToolbar: false,
    showTraffic: false,
    centerMapOnMarkerTap: true,
  ),
          );
        }
      ),
    );
  }
}