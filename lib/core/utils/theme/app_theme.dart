

import 'package:evento/core/colors/app_colors.dart';
import 'package:evento/core/utils/extenstions/color_extenstions.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static final light = ThemeData.light().copyWith(
    extensions: [
      _lightAppColors,
       _lightTextStyles,
    ],
  );
  static final _lightTextStyles = ThemeTypography(isDarkTheme: false).getTextStyles(); // Use light text styles

  static final _lightAppColors = AppColorsExtension(
  alternate: AppColors.lightAlternate,
  info: AppColors.info,
  accent4: AppColors.lightAccent4,
  primaryBackground: AppColors.lightPrimaryBackground,
  secondaryBackground: AppColors.lightSecondaryBackground,
  primary: AppColors.lightPrimary,
  secondary: AppColors.lightSecondary,
  tertiary: AppColors.lightTertiary,
  accent1: AppColors.lightAccent1,
  accent2: AppColors.lightAccent2,
  accent3: AppColors.lightAccent3,
  success: AppColors.lightSuccess,
  error: AppColors.lightError,
  warning: AppColors.lightWarning,
  shadow: AppColors.lightShadow,  // If this color exists in AppColors
  primaryText: AppColors.lightPrimaryText,
  secondaryText: AppColors.lightSecondaryText,
  rejected: AppColors.lightRejected,
  delete: AppColors.lightDelete,
  revoke: AppColors.lightRevoke,
  cancelled: AppColors.lightCancelled,
  completed: AppColors.lightCompleted,
  pending: AppColors.lightPending,
  paid: AppColors.lightPaid,
  button: AppColors.lightButton,  // If this color exists in AppColors
  buttonText: AppColors.lightButtonText,  // If this color exists in AppColors
  text: AppColors.lightText,  // If this color exists in AppColors
  cultured: AppColors.lightCultured,
  redApple: AppColors.lightRedApple,
  celadon: AppColors.lightCeladon,
  dark600: AppColors.lightDark600,
  darkText: AppColors.lightDarkText,
  gray600: AppColors.lightGray600,
  grayIcon: AppColors.lightGrayIcon,
  gunmetal: AppColors.lightGunmetal,
  lineColor: AppColors.lightLineColor,
   lineGray: AppColors.lightLineGray,
   noColor: AppColors.lightNoColor,
   primaryBtnText: AppColors.lightPrimaryBtnText,
   turquoise: AppColors.lightTurquoise,
);

  static final dark = ThemeData.light().copyWith(
    extensions: [
      _darkAppColors,
       _darkTextStyles, // Add your text styles here
    ],
  );
  static final _darkTextStyles = ThemeTypography(isDarkTheme: true).getTextStyles(); // Use light text styles

  static final _darkAppColors =AppColorsExtension(
  accent4: AppColors.darkAccent4,
  alternate: AppColors.darkAlternate,
  info: AppColors.info,
  primary: AppColors.darkPrimary,
  secondary: AppColors.darkSecondary,
  tertiary: AppColors.darkTertiary,
  accent1: AppColors.darkAccent1,
  accent2: AppColors.darkAccent2,
  accent3: AppColors.darkAccent3,
  success: AppColors.darkSuccess,
  error: AppColors.darkError,
  warning: AppColors.darkWarning,
  primaryText: AppColors.darkPrimaryText,
  secondaryText: AppColors.darkSecondaryText,
  
  rejected: AppColors.darkRejected,
  delete: AppColors.darkDelete,
  revoke: AppColors.darkRevoke,
  cancelled: AppColors.darkCancelled,
  completed: AppColors.darkCompleted,
  pending: AppColors.darkPending,
  paid: AppColors.darkPaid,
  cultured: AppColors.darkCultured,
  redApple: AppColors.darkRedApple,
  celadon: AppColors.darkCeladon,
  dark600: AppColors.darkDark600,
  darkText: AppColors.darkDarkText,
  gray600: AppColors.darkGray600,
  grayIcon: AppColors.darkGrayIcon,
  gunmetal: AppColors.darkGunmetal,
  lineColor: AppColors.darkLineColor,
   lineGray: AppColors.darkLineGray,
   noColor: AppColors.darkNoColor,
   primaryBtnText: AppColors.darkPrimaryBtnText,
   turquoise: AppColors.darkTurquoise,
   button: AppColors.darkButton,
   buttonText: AppColors.darkButtonText,
   primaryBackground: AppColors.darkPrimaryBackground,
   secondaryBackground: AppColors.darkSecondaryBackground,
   shadow: AppColors.darkShadow,
   text: AppColors.darkText,

);


 
}
