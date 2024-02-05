import 'package:evento/core/responsive/size_config.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ColumnText extends StatelessWidget {
  const ColumnText(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onTap});
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
              fontSize: SizeConfig.safeBlockHorizontal * 4,
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
                fontSize: SizeConfig.safeBlockHorizontal * 3,
                fontWeight: FontWeight.normal,
                useGoogleFonts: true,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                "See All",
                style: customTextStyle.labelSmall.override(
                  fontFamily: breeSerif,
                  color: customColors.primary,
                  fontSize: SizeConfig.safeBlockHorizontal * 2.5,
                  useGoogleFonts: true,
                ),
              ).tr(),
            )
          ],
        ),
      ],
    );
  }
}
