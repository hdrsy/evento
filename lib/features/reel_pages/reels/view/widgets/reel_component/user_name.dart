import 'package:evento/core/colors/app_colors.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:marquee/marquee.dart';

import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';

Widget userName(String userName) {
  return userName.length > 30
      ? SizedBox(
          width: screenWidth * 0.40,
          height: screenHeight * 0.03,
          child: Marquee(
            text: userName,
            scrollAxis: Axis.horizontal,
            blankSpace: 20.0,
            velocity: 70.0,
            pauseAfterRound: const Duration(seconds: 3),
            style: customTextStyle.bodyLarge.override(
                fontFamily: 'Nunito',
                color: AppColors.darkPrimaryText,
                useGoogleFonts: true,
                fontSize: 16),
          ),
        )
      : Text(
          userName,
          style: customTextStyle.bodyLarge.override(
              fontFamily: 'Nunito',
              color: AppColors.darkPrimaryText,
              useGoogleFonts: true,
              fontSize: 16),
        );
}
