// Define all sizes for texts 
import 'package:evento/core/colors/app_colors.dart';
import 'package:evento/core/utils/extenstions/text_extenstions.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}


class ThemeTypography {
  final bool isDarkTheme;
ThemeTypography({required this.isDarkTheme});
 TextExtension getTextStyles() {
    final textTheme = this.textTheme;

    return TextExtension(
      displayLarge: textTheme.displayLarge!,
      displayMedium: textTheme.displayMedium!,
      displaySmall: textTheme.displaySmall!,
      headlineLarge: textTheme.headlineLarge!,
      headlineMedium: textTheme.headlineMedium!,
      headlineSmall: textTheme.headlineSmall!,
      titleLarge: textTheme.titleLarge!,
      titleMedium: textTheme.titleMedium!,
      titleSmall: textTheme.titleSmall!,
      labelLarge: textTheme.labelLarge!,
      labelMedium: textTheme.labelMedium!,
      labelSmall: textTheme.labelSmall!,
      bodyLarge: textTheme.bodyLarge!,
      bodyMedium: textTheme.bodyMedium!,
      bodySmall: textTheme.bodySmall!,
      // Add other styles as needed
    );
  }
 TextTheme get textTheme {
    final Color primaryColor = isDarkTheme ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
    final Color secondaryColor = isDarkTheme ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    
    return TextTheme(
      displayLarge: GoogleFonts.getFont(primaryFontFamily, color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14),
      displayMedium: GoogleFonts.getFont('Montserrat', color: primaryColor, fontWeight: FontWeight.normal, fontSize: 45),
      displaySmall: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w600, fontSize: 24),
      headlineLarge: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w600, fontSize: 32),
      headlineMedium: GoogleFonts.getFont(primaryFontFamily, color: AppColors.lightPrimary, fontWeight: FontWeight.w500, fontSize: 22),
      headlineSmall: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w700, fontSize: 20),
      titleLarge: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w500, fontSize: 20),
      titleMedium: GoogleFonts.getFont(primaryFontFamily, color: secondaryColor, fontWeight: FontWeight.w500, fontSize: 18),
      titleSmall: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w600, fontSize: 16),
      labelLarge: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w500, fontSize: 14),
      labelMedium: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w500, fontSize: 11),
      labelSmall: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w500, fontSize: 11),
      bodyLarge: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.normal, fontSize: 16.0),
      bodyMedium: GoogleFonts.getFont(primaryFontFamily, color: secondaryColor, fontWeight: FontWeight.w500, fontSize: 14.0),
      bodySmall: GoogleFonts.getFont(primaryFontFamily, color: primaryColor, fontWeight: FontWeight.w500, fontSize: 12.0),
      // other text styles...
    );
  }
}