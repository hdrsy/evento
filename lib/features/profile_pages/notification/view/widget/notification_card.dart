import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/features/profile_pages/notification/model/notification_model.dart';

import '../../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key,required this.notificationModel});
  final NotificationModel notificationModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color:notificationModel.type=="seen"? null:customColors.primaryBackground,
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
                      onTap: () {
                      },
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              notificationModel.title,
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: 'Nunito',
                                color: customColors.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: false,
                              ),
                            ).tr(),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              DateFormatter.formatDate(notificationModel.createdAt),
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
                              DateFormatter.formatTime(notificationModel.createdAt),
                              style: customTextStyle.bodyMedium,
                            ).tr(),
                          ],
                        ),
                      ],
                    ),
                  ].divide(const SizedBox(width: 15)),
                ),
            notificationModel.type=="seen"?  const SizedBox():  Container(
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
              notificationModel.description,
              style: customTextStyle.bodyMedium,
            ).tr(),
          ].divide(const SizedBox(height: 15)),
        ),
      ),
    );
  }
}
