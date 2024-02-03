import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/venue_detailes_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class VenueDetailesCard extends StatelessWidget {
  VenueDetailesCard({super.key});
  final VenueDetailesController venueDetailesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildIconTextRow(context, Icons.description_outlined, 'Description',
              venueDetailesController.venue.description),
          _buildIconTextRow(context, Icons.reduce_capacity_sharp, 'Capacity',
              venueDetailesController.venue.capacity.toString()),
          _buildIconTextRow(context, Icons.location_on_outlined, 'Location',
              venueDetailesController.venue.locationDescription),
          _buildLocationButton(context),
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

  Widget _buildLocationButton(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(1, 1),
      child: ButtonWidget(
        onPressed: () {
          print('Button pressed ...');
          Get.toNamed('/SeeLocation', arguments: [
            venueDetailesController.venue.latitude,
            venueDetailesController.venue.longitude
          ]);
        },
        text: tr("See Location on Maps"),
        options: ButtonOptions(
          width: 170,
          height: 25,
          color: customColors.primary,
          textStyle: customTextStyle.titleSmall.override(
            fontFamily: primaryFontFamily,
            color: customColors.info,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            useGoogleFonts: false,
          ),
          borderSide: BorderSide(color: customColors.primary),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
