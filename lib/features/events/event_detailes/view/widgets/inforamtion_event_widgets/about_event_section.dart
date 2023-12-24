import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/main.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildAboutEventSection(BuildContext context) {
  final EventDetailesController eventDetailesController = Get.find();
  String description = eventDetailesController.eventDetailsModel.description;

  // Check if description length is greater than 40 characters
  if (description.length > 40) {
    // Use ExpandablePanel for longer descriptions
    return _buildExpandableDescription(context, description);
  } else {
    // For shorter descriptions, display normally without ExpandablePanel
    return _buildNormalDescription(context, description);
  }
}

Widget _buildNormalDescription(BuildContext context, String description) {
  return Container(
    decoration: BoxDecoration(
      color: customColors.secondaryBackground,
    ),
    child: Container(
      width: double.infinity,
      color: const Color(0x00000000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: const AlignmentDirectional(-1.00, -1.00),
            child: Text(
              "About Event",
              style: customTextStyle.bodySmall.override(
                fontFamily: 'Open Sans',
                color: customColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: Text(
                description,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: breeSerif,
                  color: customColors.secondaryText,
                  fontWeight: FontWeight.w500,
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

Widget _buildExpandableDescription(BuildContext context, String description) {
  // Determine the end index for substring
  int endIndex = description.length < 60 ? description.length : 60;

  return Container(
    decoration: BoxDecoration(
      color: customColors.secondaryBackground,
    ),
    child: ExpandableNotifier(
      child: ExpandablePanel(
        header: Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            "About Event",
            style: customTextStyle.bodySmall.override(
              fontFamily: 'Open Sans',
              color: customColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        collapsed: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  description.substring(0, endIndex) + '...',
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: breeSerif,
                    color: customColors.secondaryText,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: true,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.00, -1.00),
                child: Text(
                  "see more",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: breeSerif,
                    color: customColors.secondaryText,
                    decoration: TextDecoration.underline,
                    useGoogleFonts: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        expanded: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: Text(
                description,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: breeSerif,
                  color: customColors.secondaryText,
                  fontWeight: FontWeight.w500,
                  useGoogleFonts: true,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  "see less",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: breeSerif,
                    color: customColors.secondaryText,
                    decoration: TextDecoration.underline,
                    useGoogleFonts: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        theme: ExpandableThemeData(
          tapHeaderToExpand: false,
          tapBodyToExpand: true,
          tapBodyToCollapse: true,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          hasIcon: true,
          iconColor: customColors.secondaryText,
        ),
      ),
    ),
  );
}
