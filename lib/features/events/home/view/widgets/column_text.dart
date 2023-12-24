import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class ColumnText extends StatelessWidget {
  const ColumnText({super.key, required this.title, required this.subTitle,required this.onTap});
  final String title;
  final String subTitle;
final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            title,
            style: customTextStyle.bodyMedium.override(
              fontFamily: breeSerif,
              color: customColors.primaryText,
              fontSize: screenSize == ScreenSize.small
                  ? 18
                  : (screenSize == ScreenSize.medium ? 20 : 22  ),
              useGoogleFonts: true,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subTitle,
              style: customTextStyle.labelSmall.override(
                fontFamily: breeSerif,
                color: customColors.secondaryText,
                fontSize: screenSize == ScreenSize.small
                    ? 12
                    : (screenSize == ScreenSize.medium ? 14 : 16),
                fontWeight: FontWeight.normal,
                useGoogleFonts: true,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: onTap,
              child: Text(
                "See All",
                style: customTextStyle.labelSmall.override(
                  fontFamily: breeSerif,
                  color: customColors.primary,
                  fontSize: screenSize == ScreenSize.small
                      ? 10
                      : (screenSize == ScreenSize.medium ? 12 : 14),
                  useGoogleFonts: true,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
