import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class OrganizerEventCard extends StatelessWidget {
  const OrganizerEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return
Row(
  mainAxisSize: MainAxisSize.max,
  children: [
    InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // context.pushNamed('Event-Details');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/pexels-francesco-paggiaro-2111015.jpg',
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
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
                   "The Partisans"  ,
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
                   "Sat 19 August",
                  style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.primary,
                        fontSize: 14,
                        useGoogleFonts: false,
                      ),
                ),
                Text(
                   "19:00 PM",
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
    ToggleIcon(
      onPressed: () async {
      },
      value: false,
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
    ),
  ],
)
;
  }
}