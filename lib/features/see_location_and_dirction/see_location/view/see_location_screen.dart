import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/utils/helper/flutter_flow_google_map.dart';
import '../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../controller/see_location_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
class SeeLocation extends StatelessWidget {
  SeeLocation({super.key});
  final SeeLocationController seeLocationController =
      Get.put(SeeLocationController());
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.75,
            child: FlutterFlowGoogleMap(
              controller: seeLocationController.googleMapsController,
              onCameraIdle: (latLng) =>
                  seeLocationController.googleMapsCenter = latLng,
              initialLocation: seeLocationController.googleMapsCenter ??=
                  const LatLng(13.106061, -59.613158),
              markers: [seeLocationController.myMarker],
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
          ),
          SizedBox(
            height: 20,
          ),
          ButtonWidget(
            onPressed: () async {
              Get.toNamed('/DirctionScreen', arguments: [
                seeLocationController.latitude,
                seeLocationController.longitude
              ]);
            },
            text:tr( "Get Direction"),
            options: ButtonOptions(
              height: 40,
              // padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              color: customColors.primary,
              textStyle: customTextStyle.titleSmall.override(
                fontFamily: secondaryFontFamily,
                color: customColors.info,
                useGoogleFonts: true,
              ),
              elevation: 3,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          )
        ],
      ),
    );
  }
}
