import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/organizer/organizer_profile/controller/organizer_profile_controller.dart';
import 'package:evento/features/organizer/organizer_profile/model/organizer_profile_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizerEventCard extends StatelessWidget {
  const OrganizerEventCard(
      {super.key,
      required this.organizerProfileEvent,
      required this.modelIndex});
  final OrganizerProfileEvent organizerProfileEvent;
  final int modelIndex;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        Get.toNamed('/eventDetailes', arguments: organizerProfileEvent.id);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: organizerProfileEvent.images.isNotEmpty
                ? getImageNetwork(
                    url: "/storage/${organizerProfileEvent.images[0]}",
                    width: 70,
                    height: 70)
                : Image.asset(
                    'assets/images/pexels-francesco-paggiaro-2111015.jpg',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        organizerProfileEvent.title,
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormatter.formatDate(
                            organizerProfileEvent.startDate),
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.primary,
                          fontSize: 14,
                          useGoogleFonts: false,
                        ),
                      ),
                      Text(
                        DateFormatter.formatTime(
                            organizerProfileEvent.startDate),
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.primary,
                          fontSize: 14,
                          useGoogleFonts: false,
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
                        size: 15,
                      ),
                      Text(
                        "Grand Park",
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          useGoogleFonts: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<OrganizerProfileController>(builder: (controller) {
            return ToggleIcon(
              onPressed: () async {
                controller.followOrUnFollowEvent(
                    organizerProfileEvent.id, modelIndex);
              },
              value: controller.organizerProfileModel
                      .organizedEvents[modelIndex].isFollowedByAuthUser
                  ? true
                  : false,
              onIcon: Icon(
                Icons.favorite,
                color: customColors.primary,
                size: 20,
              ),
              offIcon: Icon(
                Icons.favorite_border,
                color: customColors.secondaryText,
                size: 20,
              ),
            );
          }),
        ],
      ),
    );
  }
}
