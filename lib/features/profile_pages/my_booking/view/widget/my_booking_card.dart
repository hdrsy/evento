import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class MyBookingCard extends StatelessWidget {
  const MyBookingCard(
      {super.key,
      required this.isCanceldSection,
      this.leftButtonOnTap,
      this.leftButtonTitle,
      required this.bookingStatus});

  final Function()? leftButtonOnTap;
  final String? leftButtonTitle;
  final bool isCanceldSection;
  final String bookingStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildImageSection(context),
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

  Widget _buildImageSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildImage(),
            Expanded(child: _buildEventDetails(context)),
          ].divide(const SizedBox(width: 10)),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        'https://picsum.photos/seed/886/600',
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEventDetails(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEventName(context),
        _buildEventTime(context),
        _buildLocationAndPrice(context),
      ].divide(const SizedBox(height: 8)),
    );
  }

  Widget _buildEventName(BuildContext context) {
    return Text(
      "DJ",
      style: customTextStyle.bodyMedium.override(
        fontFamily: 'Nunito',
        color: customColors.primaryText,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        useGoogleFonts: true,
      ),
    );
  }

  Widget _buildEventTime(BuildContext context) {
    return Text(
      "Sat, 20 Nov - 20:00 - 21:00",
      style: customTextStyle.bodyMedium.override(
        fontFamily: 'Nunito',
        color: customColors.primary,
        fontWeight: FontWeight.w600,
        useGoogleFonts: true,
      ),
    );
  }

  Widget _buildLocationAndPrice(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildLocation(context),
        _buildPaidButton(context),
      ],
    );
  }

  Widget _buildLocation(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: customColors.primary,
          size: 15,
        ),
        Text(
          "Christmas",
          style: customTextStyle.bodyMedium,
        ),
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
