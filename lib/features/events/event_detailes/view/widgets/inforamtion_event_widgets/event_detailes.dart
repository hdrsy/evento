import 'package:evento/core/responsive/responsive.dart';

import '../../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../../../core/utils/animation/animation_def.dart';
import '../../../../../../core/utils/animation/animation_util.dart';
import '../../../../../../core/utils/helper/date_formatter.dart';
import '../../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../controller/event_detailes_controller.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildEventDetails(BuildContext context) {
  final EventDetailesController eventDetailesController = Get.find();
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        decoration: const BoxDecoration(),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Event Date and Time
            Align(
              alignment: const AlignmentDirectional(-1.00, -1.00),
              child: Text(
                tr("Date & Location"),
                style: customTextStyle.bodyMedium.copyWith(
                    fontSize: 16,
                    color: customColors.primaryText,
                    fontWeight: FontWeight.w700),
              ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconWithContainer(
                  backgroundColor: customColors.tertiary,
                  buttonSize: 50,
                  borderRadius: 40,
                  icon: Icons.calendar_month,
                  onTap: () {},
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            DateFormatter.formatTime(eventDetailesController
                                .eventDetailsModel.startDate),
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: breeSerif,
                              fontSize: 14,
                              useGoogleFonts: false,
                            ),
                          ), 
                                    // 'Add to My Calendar' Button
                    SizedBox(width: screenWidth*0.13  ,),
                          ButtonWidget(
                            onPressed: () {
                              eventDetailesController
                                  .createAndAddReminderEvents();
                            },
                            text: tr("Add to My Calendar"),
                            options: ButtonOptions(
                              width: 170,
                              height: 25,
                              padding: const EdgeInsetsDirectional
                                  .fromSTEB(20, 0, 20, 0),
                              iconPadding: const EdgeInsetsDirectional
                                  .fromSTEB(0, 0, 0, 0),
                              color: customColors.primary,
                              textStyle:
                                  customTextStyle.titleSmall.override(
                                fontFamily: breeSerif,
                                color: customColors.info,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: false,
                              ),
                              borderSide: BorderSide(
                                color: customColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ])
                  ],
                ),
              ].divide(const SizedBox(width: 15)),
            ),
          ],
        ),
      ),
      // Event Location
      Row(
        mainAxisSize: MainAxisSize.max,
        
        children: [
          IconWithContainer(
            backgroundColor: customColors.tertiary,
            icon: Icons.location_on_outlined,
            onTap: () {},
            buttonSize: 50,
            borderRadius: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                eventDetailesController
                    .eventDetailsModel.venue.governorate,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: primaryFontFamily,
                  color: customColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts: true,
                ),
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
                       
                       SizedBox(width: screenWidth*0.04,),  
                     // 'See Location on Maps' Button
                  Row(
                    children: [
                      ButtonWidget(
                        onPressed: () {
                      eventDetailesController.openMap();
                        },
                        text: tr("See Location on Maps"),
                        options: ButtonOptions(
                      width: 170,
                      height: 25,
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                   
                ],
              ).animateOnPageLoad(
                  animationsMap['rowOnPageLoadAnimation1']!),
            ],
          ),
        ].divide(const SizedBox(width: 15)),
      ),
    ].divide(const SizedBox(height: 10)),
  );
}
