import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/responsive/responsive.dart';
import '../controller/dirction_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class DirctionScreen extends StatelessWidget {
  DirctionScreen({super.key});
  final DirctionController dirctionController = Get.put(DirctionController());
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
      body: GetBuilder<DirctionController>(builder: (context) {
        return SizedBox(
            width: double.infinity,
            height: screenHeight,
            child: GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              initialCameraPosition: dirctionController.googleMapsCenter,
              polylines: dirctionController.polylines,
              onCameraIdle: () => dirctionController.googleMapsCenter,
              markers: {
                if (dirctionController.userMarker != null)
                  dirctionController.userMarker!,
                dirctionController.myMarker,
              },
              mapType: MapType.normal,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              trafficEnabled: true,
            ));
      }),
    );
  }
}
