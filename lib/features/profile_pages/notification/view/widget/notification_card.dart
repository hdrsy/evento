import 'package:evento/core/shared/functions/fix_notification_title.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/features/profile_pages/notification/controller/notification_controller.dart';
import 'package:evento/features/profile_pages/notification/model/notification_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

int extractNumberAfterLastSpace(String text) {
  final RegExp regex = RegExp(r'(\d+)\b(?!\s)');
  final matches = regex.allMatches(text);
  Match? lastMatch;

  for (final match in matches) {
    lastMatch = match;
  }

  if (lastMatch != null) {
    return int.parse(lastMatch
        .group(0)!); // Using ! as group(0) will not be null if a match is found
  }
  return 0; // Return null if no number is found
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notificationModel});
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notificationModel.type = 1;
        Get.find<NotificationController>().update();
        if (notificationModel.title.contains("navigate")) {
          String targetRout = extractWordAfterNavigate(notificationModel.title);
          if (targetRout.toLowerCase() == "organizer") {
            Get.toNamed('/OrganizerProfileScreen', arguments: [
              extractNumberAfterLastSpace(notificationModel.title),
              0
            ]);
          } else if (targetRout.toLowerCase() == "venue") {
            Get.toNamed('/VenueDetailesForUserScreen',
                arguments:
                    extractNumberAfterLastSpace(notificationModel.title));
          } else if (targetRout.toLowerCase() == "event") {
            Get.toNamed('/eventDetailes', parameters: {
              'id': extractNumberAfterLastSpace(notificationModel.title)
                  .toString(),
            });
          }
        } else {
          if (notificationModel.title == "New Friend Request") {
            Get.toNamed('/FreindsScreen', arguments: 1);
          } else if (notificationModel.title == "New Friend") {
            Get.toNamed('/FreindsScreen');
          } else if (notificationModel.title == "Booked Successfully") {
            Get.toNamed('/MyBookingScreen');
          } else if (notificationModel.title == "Ticket Resell ") {
            Get.toNamed('/MyBookingScreen');
          } else if (notificationModel.title.contains("Invitation")) {
            String description = notificationModel.description;
            int lastSpaceIndex =
                description.lastIndexOf(' '); // or use another delimiter
            String eventIdString = description.substring(lastSpaceIndex + 1);
            int eventId = int.parse(eventIdString);

            Get.toNamed('/eventDetailes', parameters: {
              'id': eventId.toString(),
            });
          }
        }
      },
      child: GetBuilder<NotificationController>(builder: (ccontext) {
        return Container(
          decoration: BoxDecoration(
            color: notificationModel.type == 1
                ? null
                : customColors.primaryBackground,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconWithContainer(
                          backgroundColor: const Color(0xFFDAC9EE),
                          borderRadius: 40,
                          buttonSize: 50,
                          icon: Icons.calendar_month,
                          iconColor: customColors.primary,
                          onTap: () {},
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    Get.locale == Locale('en')
                                        ? removeNavigateToEnd(
                                            notificationModel.title)
                                        : removeNavigateToEnd(
                                            notificationModel.titlear),
                                    style: customTextStyle.bodyMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.primaryText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: false,
                                    ),
                                  ).tr(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  DateFormatter.formatDate(
                                      notificationModel.createdAt),
                                  style: customTextStyle.bodyMedium,
                                ).tr(),
                                SizedBox(
                                  height: 20,
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: customColors.secondary,
                                  ),
                                ),
                                Text(
                                  DateFormatter.formatTime(
                                      notificationModel.createdAt),
                                  style: customTextStyle.bodyMedium,
                                ).tr(),
                              ],
                            ),
                          ],
                        ),
                      ].divide(const SizedBox(width: 15)),
                    ),
                    notificationModel.type == 1
                        ? const SizedBox()
                        : Container(
                            width: 50,
                            height: 25,
                            decoration: BoxDecoration(
                              color: customColors.alternate,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0.00, 0.00),
                              child: Text(
                                "New",
                                style: customTextStyle.titleSmall.override(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  color: customColors.info,
                                  useGoogleFonts: false,
                                ),
                              ).tr(),
                            ),
                          ),
                  ],
                ),
                Text(
                  Get.locale == Locale('en')
                      ? removeLastWordIfInt(notificationModel.description)
                      : removeLastWordIfInt(notificationModel.descriptionar),
                  style: customTextStyle.bodyMedium,
                ).tr(),
              ].divide(const SizedBox(height: 15)),
            ),
          ),
        );
      }),
    );
  }
}

String removeLastWordIfInt(String input) {
  // Split the string into a list of words
  List<String> words = input.split(' ');

  // Check if the last word is an integer
  if (words.isNotEmpty && int.tryParse(words.last) != null) {
    // Remove the last word if it's an integer
    words.removeLast();
  }

  // Join the list back into a string and return
  return words.join(' ');
}
