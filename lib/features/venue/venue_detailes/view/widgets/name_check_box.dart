import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/rate_event_widget.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/customize_event/venue/model/venue_model.dart';
import 'package:evento/main.dart';
import 'package:marquee/marquee.dart';

import '../../controller/venue_detailes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class NameCheckBox extends StatelessWidget {
  NameCheckBox({
    super.key,
    required this.venue,
  });
  final Venue venue;
  final VenueDetailesForUserController venueDetailesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidth * 0.60,
          height: screenHeight * 0.03,
          child: venue.name.length > 30
              ? Marquee(
                  text: venue.name,
                  scrollAxis: Axis.horizontal,
                  blankSpace: 20.0,
                  velocity: 70.0,
                  pauseAfterRound: const Duration(seconds: 3),
                  style: customTextStyle.headlineSmall)
              : Text(
                  venue.name,
                  style: customTextStyle.headlineSmall,
                ),
        ),
        GestureDetector(
          onTap: () async {
            // context.pushNamed('Services');
          },
          child: Container(
              decoration: BoxDecoration(
                color: customColors.secondaryBackground,
              ),
              child: GestureDetector(
                onTap: () async {
                  await showButtonSheet(
                      context: context,
                      widget: ReviewEventWidget(
                          ratingTarget: tr("Venue"),
                          idKey: tr("venue_id"),
                          url: ServerConstApis.reviewVenue,
                          id: venue.id),
                      height: 450);
                },
                child: Text(
                  "Review Venue",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),
                ).tr(),
              )),
        ),
      ],
    );
  }
}
