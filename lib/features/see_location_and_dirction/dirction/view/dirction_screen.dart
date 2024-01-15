import '../../../../core/responsive/responsive.dart';
import '../../../../core/utils/helper/flutter_flow_google_map.dart';
import '../controller/dirction_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class DirctionScreen extends StatelessWidget {
   DirctionScreen({super.key});
final DirctionController dirctionController=Get.put(DirctionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Location"),
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
    mapType: MapType.hybrid,
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