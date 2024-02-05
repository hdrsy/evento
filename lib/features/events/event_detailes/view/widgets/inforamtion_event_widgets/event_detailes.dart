import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildEventDetails(BuildContext context) {
  final EventDetailesController eventDetailesController = Get.find();
  return Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        tr("Date & Location"),
        style: customTextStyle.bodyMedium.copyWith(
            fontSize: 14,
            color: customColors.primaryText,
            fontWeight: FontWeight.w700),
      ),
      // Event Date and Time
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${DateFormatter.formatDate(eventDetailesController.eventDetailsModel.startDate)}, ${DateFormatter.getYear(eventDetailesController.eventDetailsModel.startDate)}",
            style: customTextStyle.bodyMedium.override(
              fontFamily: primaryFontFamily,
              color: customColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              useGoogleFonts: true,
            ),
          ),
          ButtonWidget(
            onPressed: () {
              eventDetailesController.createAndAddReminderEvents();
            },
            text: "Add to My Calendar",
            options: ButtonOptions(
              width: 170,
              height: 25,
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              color: customColors.primary,
              textStyle: customTextStyle.titleSmall.override(
                fontFamily: breeSerif,
                color: customColors.info,
                fontSize: 10,
                fontWeight: FontWeight.normal,
                useGoogleFonts: false,
              ),
              borderSide: BorderSide(
                color: customColors.primary,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ].divide(const SizedBox(width: 15)),
      ),
      Text(
        DateFormatter.formatTime(
            eventDetailesController.eventDetailsModel.startDate),
        style: customTextStyle.bodyMedium.override(
          fontFamily: breeSerif,
          fontSize: 14,
          useGoogleFonts: false,
        ),
      ),

      // 'Add to My Calendar' Button

      // Event Location

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            eventDetailesController.eventDetailsModel.venue.governorate,
            style: customTextStyle.bodyMedium.override(
              fontFamily: primaryFontFamily,
              color: customColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              useGoogleFonts: true,
            ),
          ),
          ButtonWidget(
            onPressed: () {
              eventDetailesController.openMap();
            },
            text: "See Location on Maps",
            options: ButtonOptions(
              width: 170,
              height: 25,
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              color: customColors.primary,
              textStyle: customTextStyle.titleSmall.override(
                fontFamily: breeSerif,
                color: customColors.info,
                fontSize: 10,
                fontWeight: FontWeight.normal,
                useGoogleFonts: false,
              ),
              borderSide: BorderSide(
                color: customColors.primary,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.location_on_outlined,
            color: customColors.primary,
            size: 20,
          ),
          Obx(
            () => Text(
              eventDetailesController.distance.value,
              style: customTextStyle.bodyMedium.copyWith(
                // fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                // useGoogleFonts: false,
              ),
            ),
          ),
        ],
      ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation1']!),
    ].divide(const SizedBox(height: 5)),
  );
}
