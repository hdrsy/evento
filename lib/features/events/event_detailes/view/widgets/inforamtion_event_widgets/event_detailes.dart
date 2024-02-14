import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            fontSize: 14.sp,
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
              fontSize: 16.sp,
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
              width: 170.w,
              height: 25.h,
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              color: customColors.primaryBackground,
              textStyle: customTextStyle.titleSmall.override(
                fontFamily: breeSerif,
                color: customColors.primaryText,
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                useGoogleFonts: false,
              ),
              borderSide: BorderSide(
                color: customColors.primaryBackground,
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
          fontSize: 14.sp,
          useGoogleFonts: false,
        ),
      ),
      Divider(
        thickness: 0.5,
        color: customColors.secondary,
        endIndent: screenWidth * 0.5,
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            eventDetailesController.eventDetailsModel.venue.governorate,
            style: customTextStyle.bodyMedium.override(
              fontFamily: primaryFontFamily,
              color: customColors.primaryText,
              fontSize: 16.sp,
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
              width: 170.w,
              height: 25.h,
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              color: customColors.primaryBackground,
              textStyle: customTextStyle.titleSmall.override(
                fontFamily: breeSerif,
                color: customColors.primaryText,
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                useGoogleFonts: false,
              ),
              borderSide: BorderSide(
                color: customColors.primaryBackground,
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
            size: 20.sp,
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
