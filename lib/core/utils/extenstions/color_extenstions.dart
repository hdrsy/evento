import 'package:flutter/material.dart';

/// for apply all propirties that exist in design
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color alternate;
  final Color primaryText;
  final Color secondaryText;
  final Color primaryBackground;
  final Color secondaryBackground;
  final Color accent1;
  final Color accent2;
  final Color accent3;
  final Color accent4;
  final Color success;
  final Color error;
  final Color warning;
  final Color info;
  final Color shadow;
  final Color rejected;
  final Color delete;
  final Color revoke;
  final Color cancelled;
  final Color completed;
  final Color pending;
  final Color paid;
  final Color button;
  final Color buttonText;
  final Color text;
  final Color cultured;
  final Color redApple;
  final Color celadon;
  final Color turquoise;
  final Color gunmetal;
  final Color grayIcon;
  final Color darkText;
  final Color dark600;
  final Color gray600;
  final Color lineGray;
  final Color primaryBtnText;
  final Color lineColor;
  final Color noColor;
  AppColorsExtension({
    required this.rejected,
    required this.delete,
    required this.revoke,
    required this.info,
    required this.cancelled,
    required this.completed,
    required this.pending,
    required this.paid,
    required this.text,
    required this.alternate,
    required this.accent4,
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.accent1,
    required this.accent2,
    required this.accent3,
    required this.success,
    required this.error,
    required this.warning,
    
    required this.primaryText,
    required this.secondaryText,
    required this.shadow,
    required this.button,
    required this.buttonText,
    required this.cultured,
    required this.redApple,
    required this.celadon,
    required this.turquoise,
    required this.gunmetal,
    required this.grayIcon,
    required this.darkText,
    required this.dark600,
    required this.gray600,
    required this.lineGray,
    required this.primaryBtnText,
    required this.lineColor,
    required this.noColor,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? alternate,
    Color? accent4,
    Color? primaryBackGround,
    Color? secondaryBackGround,
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? accent1,
    Color? accent2,
    Color? accent3,
    Color? success,
    Color? error,
    Color? warning,
    Color? primaryText,
    Color? secondaryText,

    Color? shadow,
    Color? rejected,
    Color? delete,
    Color? revoke,
    Color? cancelled,
    Color? completeded,
    Color? pending,
    Color? paid,
    Color? seeDetailes,
    Color? text1,
    Color? text2,
    Color? favourite,
    Color? favouriteOutline,
    Color? lightCultured,
    Color? lightRedApple,
    Color? lightCeladon,
  }) {
    return AppColorsExtension(
      accent4: accent4 ?? this.accent4,
      info: info,
      alternate: alternate ?? this.alternate,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      accent1: accent1 ?? this.accent1,
      accent2: accent2 ?? this.accent2,
      accent3: accent3 ?? this.accent3,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      
      shadow: shadow ?? this.shadow,
      rejected: rejected ?? this.rejected,
      delete: delete ?? this.delete,
      revoke: revoke ?? this.revoke,
      cancelled: cancelled ?? this.cancelled,
      pending: pending ?? this.pending,
      paid: paid ?? this.paid,
      completed: completed,
      text: text,
      primaryBackground: primaryBackground,
      secondaryBackground: secondaryBackground,
      button: button,
      buttonText: buttonText,
      celadon: celadon,
      cultured: cultured,
      dark600: dark600,
      darkText: darkText,
      gray600: gray600,
      grayIcon: grayIcon,
      gunmetal: gunmetal,
      lineColor: lineColor,
      lineGray: lineGray,
      noColor: noColor,
      primaryBtnText: primaryBtnText,
      redApple: redApple,
      turquoise: turquoise
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
      covariant ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this; // if other isn't AppColorsExtension, return current instance
    }

    // Cast other to AppColorsExtension for easier access to its properties
    final otherColors = other;

    // Interpolate between the current and other theme colors based on t
    return AppColorsExtension(
      alternate: Color.lerp(alternate, otherColors.alternate, t)!,
      accent4: Color.lerp(accent4, otherColors.accent4, t)!,
      primary: Color.lerp(primary, otherColors.primary, t)!,
      secondary: Color.lerp(secondary, otherColors.secondary, t)!,
      tertiary: Color.lerp(tertiary, otherColors.tertiary, t)!,
      accent1: Color.lerp(accent1, otherColors.accent1, t)!,
      accent2: Color.lerp(accent2, otherColors.accent2, t)!,
      accent3: Color.lerp(accent3, otherColors.accent3, t)!,
      success: Color.lerp(success, otherColors.success, t)!,
      error: Color.lerp(error, otherColors.error, t)!,
      warning: Color.lerp(warning, otherColors.warning, t)!,
      primaryText: Color.lerp(primaryText, otherColors.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, otherColors.secondaryText, t)!,
      info: Color.lerp(info, otherColors.info, t)!,
      
      shadow: Color.lerp(shadow, otherColors.shadow, t)!,
      rejected: Color.lerp(rejected, otherColors.rejected, t)!,
      delete: Color.lerp(delete, otherColors.delete, t)!,
      revoke: Color.lerp(revoke, otherColors.revoke, t)!,
      cancelled: Color.lerp(cancelled, otherColors.cancelled, t)!,
      completed: Color.lerp(completed, otherColors.completed, t)!,
      pending: Color.lerp(pending, otherColors.pending, t)!,
      paid: Color.lerp(paid, otherColors.paid, t)!,
      text: Color.lerp(text, otherColors.text, t)!,
      button: Color.lerp(button, otherColors.button, t)!,
      buttonText: Color.lerp(buttonText, otherColors.buttonText, t)!,
      celadon: Color.lerp(celadon, otherColors.celadon, t)!,
      cultured: Color.lerp(cultured, otherColors.cultured, t)!,
      dark600: Color.lerp(dark600, otherColors.dark600, t)!,
      darkText: Color.lerp(darkText, otherColors.darkText, t)!,
      gray600: Color.lerp(gray600, otherColors.gray600, t)!,
      grayIcon: Color.lerp(grayIcon, otherColors.grayIcon, t)!,
      gunmetal: Color.lerp(gunmetal, otherColors.gunmetal, t)!,
      lineColor: Color.lerp(lineColor, otherColors.lineColor, t)!,
      lineGray: Color.lerp(lineGray, otherColors.lineGray, t)!,
      noColor: Color.lerp(noColor, otherColors.noColor, t)!,
      primaryBackground: Color.lerp(primaryBackground, otherColors.primaryBackground, t)!,
      primaryBtnText: Color.lerp(primaryBtnText, otherColors.primaryBtnText, t)!,
      redApple: Color.lerp(redApple, otherColors.redApple, t)!,
      secondaryBackground: Color.lerp(secondaryBackground, otherColors.secondaryBackground, t)!,
      turquoise: Color.lerp(turquoise, otherColors.turquoise, t)!,
      );
  }
}
