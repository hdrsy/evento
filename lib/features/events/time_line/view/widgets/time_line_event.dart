import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/time_line/model/time_line_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

Widget buildTimelineEvent(BuildContext context, TimelineModel event) {
   return  Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.time,
                  style: customTextStyle.bodyMedium.override(
                        fontFamily: breeSerif,
                        color: customColors.primaryText,
                        useGoogleFonts: true,
                      ),
                ),
                const SizedBox(height: 20),
                // Additional event time entries can go here if necessary
              ],
            ),
            SizedBox(
              height: 50, // Adjust as needed
              child: VerticalDivider(
                thickness: 3,
                color: customColors.secondaryText,
                indent: 5,
                endIndent: 5,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Text(
                  event.activity,
                  style: customTextStyle.bodyMedium.override(
                        fontFamily: breeSerif,
                        color: customColors.primaryText,
                        useGoogleFonts: true,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }