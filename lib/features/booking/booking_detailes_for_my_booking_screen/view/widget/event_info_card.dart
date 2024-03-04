import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/booking_detailes_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class EventInfoCard2 extends StatelessWidget {
  EventInfoCard2({super.key});
  final BookingDetailesForMyBookingController bookingDetailesController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1, -1),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Text(
              "Event Information",
              style: customTextStyle.headlineMedium.override(
                  color: customColors.primary,
                  fontFamily: secondaryFontFamily,
                  useGoogleFonts: true),
            ).tr(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: customColors.secondary,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleItemData(
                    title: tr("Event"),
                    subTitle: bookingDetailesController.eventDetailsModel.title,
                  ),
                  SingleItemData(
                    title: tr("Event Location"),
                    subTitle: bookingDetailesController
                        .eventDetailsModel.venue.governorate,
                  ),
                  SingleItemData(
                    title: tr("Event Organizer"),
                    subTitle: "Evento",
                  ),
                ].divide(const SizedBox(height: 18)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SingleItemData extends StatelessWidget {
  const SingleItemData({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle.labelMedium.override(
            fontFamily: 'Nunito',
            color: customColors.secondaryText,
            fontSize: 14,
            useGoogleFonts: true,
          ),
        ),
        Text(
          subTitle,
          style: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            color: customColors.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            useGoogleFonts: true,
          ),
        ),
      ].divide(const SizedBox(height: 5)),
    );
  }
}
