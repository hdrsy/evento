import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

Widget marqueeTitle(String title,
    {String? fontFamily = 'Readex Pro',
    int titleMaxLength = 20,
    double heigthFromTheScreen = 0.023,
    double widthFromTheScreen = 0.3,double fontSize=18}) {
  return title.length > titleMaxLength
      ? SizedBox(
          width: screenWidth * widthFromTheScreen,
          height: screenHeight * heigthFromTheScreen,
          child: Marquee(
            text: title.tr(),
            scrollAxis: Axis.horizontal,
            blankSpace: 20.0,
            velocity: 70.0,
            pauseAfterRound: const Duration(seconds: 3),
            style: customTextStyle.bodyMedium.copyWith(
                color: customColors.primaryText,
                fontFamily: fontFamily,
                fontSize: fontSize,
                fontWeight: FontWeight.w600),
          ),
        )
      : Text(
          title,
          style: customTextStyle.bodyMedium.copyWith(
              color: customColors.primaryText,
              fontSize: fontSize,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w600),
        );
}

Widget marqueeNormalText(String title, Color? textColor,
    {String? fontFamily = 'Readex Pro',
    int titleMaxLength = 60,
    double heigthFromTheScreen = 0.023,
    double widthFromTheScreen = 0.3}) {
  return title.length > titleMaxLength
      ? SizedBox(
          width: screenWidth * widthFromTheScreen,
          height: screenHeight * heigthFromTheScreen,
          child: Marquee(
            text: title.tr(),
            scrollAxis: Axis.horizontal,
            blankSpace: 20.0,
            velocity: 70.0,
            pauseAfterRound: const Duration(seconds: 3),
            style: customTextStyle.bodyMedium.copyWith(
                color: textColor ?? customColors.secondaryText,
                fontFamily: fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        )
      : Text(
          title,
          style: customTextStyle.bodyMedium.copyWith(
              color: textColor ?? customColors.secondaryText,
              fontSize: 16,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w400),
        );
}