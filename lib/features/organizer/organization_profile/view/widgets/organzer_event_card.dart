import '../../../../../core/shared/widgets/buttons/toggle_icon.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/helper/date_formatter.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/organization_profile_controller.dart';
import '../../model/organizer_profile_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class OrganizationEventCard extends StatelessWidget {
  const OrganizationEventCard(
      {super.key,
      required this.organizerProfileEvent,
      required this.modelIndex});
  final OrganizationProfileEvent organizerProfileEvent;
  final int modelIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.toNamed('/ShowAllBookingInEventForOrganizerScreen',
            arguments: organizerProfileEvent.id);
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
                      ).tr(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<OrganizationProfileController>(builder: (controller) {
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
