import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/booking_detailes/controller/booking_detailes_controller.dart';
import 'package:evento/features/booking_detailes_for_my_booking_screen/controller/booking_detailes_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventInfoCard extends StatelessWidget {
   EventInfoCard({super.key});
final BookingDetailesForMyBookingController bookingDetailesController=Get.find();
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
        useGoogleFonts: true
      ),
    ),
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
          SingleItemData(title: "Event",subTitle: bookingDetailesController.eventDetailsModel.title,),
          SingleItemData(title: "Event Location",subTitle: bookingDetailesController.eventDetailsModel.venue.governorate,),
          SingleItemData(title: "Event Organizer",subTitle: bookingDetailesController.eventDetailsModel.organizer!= null?"${bookingDetailesController.eventDetailsModel.organizer!.firstName} ${bookingDetailesController.eventDetailsModel.organizer!.lastName}":"Evento",),
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
    required this. title,
    required this. subTitle,

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