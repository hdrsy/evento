import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/animation/animation_text.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/my_booking/model/my_cancel_booking_model.dart';
import 'package:evento/features/profile_pages/my_booking/model/up_coming_booking.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class MyBookingCard extends StatelessWidget {
  const MyBookingCard(
      {super.key,
      required this.isCanceldSection,
      required this.model,
      this.leftButtonOnTap,
this.eventBooking,
      this.leftButtonTitle,
      required this.bookingStatus});
final List<EventBooking>? eventBooking;
  final Function()? leftButtonOnTap;
  final String? leftButtonTitle;
  final bool isCanceldSection;
  final String bookingStatus;
   final CancelledEvent model;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildImageSection(context,model),
            Divider(
              thickness: 1,
              color: customColors.primaryBackground,
            ),
            isCanceldSection ? const SizedBox() : _buildButtonsRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context,CancelledEvent model) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildImage(model.images),
            Expanded(child: _buildEventDetails(context,model)),
          ].divide(const SizedBox(width: 10)),
        ),
      ),
    );
  }

  Widget _buildImage(List<String> img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child:img.isNotEmpty? getImageNetwork(url: "/storage/${img[0]}", width: 110, height: 110):Image.network(
        'https://picsum.photos/seed/886/600',
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      
      
       
    );
  }

  Widget _buildEventDetails(BuildContext context,CancelledEvent model) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEventName(context, model.title),
        _buildEventTime(context,model),
        _buildLocationAndPrice(context,model),
      ].divide(const SizedBox(height: 8)),
    );
  }

  Widget _buildEventName(BuildContext context,String title) {
    return Text(
      title,
      style: customTextStyle.bodyMedium.override(
        fontFamily: 'Nunito',
        color: customColors.primaryText,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        useGoogleFonts: true,
      ),
    );
  }

  Widget _buildEventTime(BuildContext context,CancelledEvent model) {
    return Text(
      "${DateFormatter.formatDate(model.startDate)} - ${DateFormatter.formatTime(model.startDate)} - ${DateFormatter.formatTime(model.endDate)}",
      style: customTextStyle.bodyMedium.override(
        fontFamily: 'Nunito',
        color: customColors.primary,
        fontWeight: FontWeight.w600,
        useGoogleFonts: true,
      ),
    );
  }

  Widget _buildLocationAndPrice(BuildContext context,CancelledEvent model) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildLocation(context,"${model.venue.governorate} / ${model.venue.locationDescription}"),
        Spacer(),
        _buildPaidButton(context),
      ],
    );
  }

  Widget _buildLocation(BuildContext context,String location) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: customColors.primary,
          size: 15,
        ),
        SizedBox(
          
          width: screenWidth * 0.25,
          height: screenHeight * 0.03,
          child: Marquee(
            text: location,
            scrollAxis: Axis.horizontal,
            blankSpace: 20.0,
            velocity: 70.0,
            pauseAfterRound: const Duration(seconds: 3),
            style: customTextStyle.bodyMedium.override(
              useGoogleFonts: false,
                color: customColors.secondaryText,
                fontFamily: secondaryFontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
        )
       
      ],
    );
  }

  Widget _buildPaidButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: ButtonWidget(
        onPressed: () {
        },
        text: bookingStatus,
        options: ButtonOptions(
          height: 22,
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          color: customColors.secondaryBackground,
          textStyle: customTextStyle.titleSmall.override(
            fontFamily: 'Nunito',
            color: bookingStatus == "Canceled"
                ? customColors.error
                : (bookingStatus == "Completed"
                    ? customColors.success
                    : customColors.primary),
            fontSize: 10,
            fontWeight: FontWeight.normal,
            useGoogleFonts: true,
          ),
          borderSide: BorderSide(
            color: bookingStatus == "Canceled" 
    ? customColors.error 
    : (bookingStatus == "Completed" 
        ? customColors.success 
        : customColors.alternate)
,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCancelButton(context),
          _buildViewTicketButton(context),
        ].divide(const SizedBox(
          width: 8,
        )),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return ButtonWidget(
      onPressed: leftButtonOnTap,
      text: leftButtonTitle!,
      options: ButtonOptions(
        height: 25,
        padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.secondaryBackground,
        textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          color: customColors.primary,
          fontSize: 12,
          useGoogleFonts: true,
        ),
        borderSide: BorderSide(
          color: customColors.primary,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildViewTicketButton(BuildContext context) {
    return ButtonWidget(
      onPressed: () {
      //  Get.toNamed('/BookingDetailesScreen',arguments: [eventDetailsModel,ticketList])
        
      },
      text: "View E-Ticket",
      options: ButtonOptions(
        height: 25,
        padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.primary,
        textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          fontSize: 12,
          color: customColors.info,
          useGoogleFonts: true,
        ),
        borderSide: BorderSide(
          color: customColors.primary,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
