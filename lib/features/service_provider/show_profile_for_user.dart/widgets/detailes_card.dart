import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ServiceAccordingDetailesForUserController.dart';

class DetailesCard extends StatelessWidget {
  DetailesCard({super.key});
  final ServiceAccordingDetailesForUserController
      serviceAccordingDetailesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildIconTextRow(context, Icons.description_outlined, 'Description',
              serviceAccordingDetailesController.serviceProvider.description),
          _buildIconTextRow(
              context,
              Icons.location_on_outlined,
              'Location',
              serviceAccordingDetailesController
                  .serviceProvider.locationWorkGovernorate),
          // _buildLocationButton(context),
        ]
            .divide(const SizedBox(height: 20))
            .addToStart(const SizedBox(height: 16))
            .addToEnd(const SizedBox(height: 16)),
      ),
    );
  }

  Widget _buildIconTextRow(
      BuildContext context, IconData icon, String titleKey, String descKey) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(icon, color: customColors.primary, size: 20),
            const SizedBox(width: 5),
            Text(
              titleKey,
              style: customTextStyle.bodyMedium.override(
                fontFamily: primaryFontFamily,
                color: customColors.primaryText,
                useGoogleFonts: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          descKey,
          style: customTextStyle.bodyMedium,
        ),
      ],
    );
  }
  // Widget _buildLocationButton(BuildContext context) {
  //   return Align(
  //     alignment: const AlignmentDirectional(1, 1),
  //     child: ButtonWidget(
  //       onPressed: () {
  //        Get.toNamed('/SeeLocation',arguments: [serviceAccordingDetailesController.serviceProvider.latitude,serviceAccordingDetailesController.serviceProvider.longitude]);
  //       },
  //       text:tr( "See Location on Maps"),
  //       options: ButtonOptions(
  //         width: 170,
  //         height: 25,
  //         color: customColors.primary,
  //         textStyle: customTextStyle.titleSmall.override(
  //           fontFamily: primaryFontFamily,
  //           color: customColors.info,
  //           fontSize: 12,
  //           fontWeight: FontWeight.w500,
  //           useGoogleFonts: false,
  //         ),
  //         borderSide: BorderSide(color: customColors.primary),
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //     ),
  //   );
  // }
}
