import '../../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key,required this.isReaded});
  final bool isReaded;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color:isReaded? null:customColors.primaryBackground,
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
                              "Booking Successful!",
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
                              "11 Nov , 2023",
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
                              "20:30 PM",
                              style: customTextStyle.bodyMedium,
                            ).tr(),
                          ],
                        ),
                      ],
                    ),
                  ].divide(const SizedBox(width: 15)),
                ),
            isReaded?  const SizedBox():  Container(
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
                        useGoogleFonts: false,
                      ),
                    ).tr(),
                  ),
                ),
              ],
            ),
            Text(
              "You have successfully booked the Art Workshops.The event........",
              style: customTextStyle.bodyMedium,
            ).tr(),
          ].divide(const SizedBox(height: 15)),
        ),
      ),
    );
  }
}
