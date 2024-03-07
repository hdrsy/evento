import 'package:evento/features/profile_pages/profile/view/widgets/account_text.dart';

import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../core/utils/theme/theme_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';

class ThemeSwicth extends StatelessWidget {
  ThemeSwicth({super.key});
  // final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AccountText(),
        // const ThemeToggleSwitch()
        themeSwitcher(context)
      ],
    );
  }
}

Widget themeSwitcher(BuildContext context) {
  ThemeController themeController = Get.find();
  final switchController =
      ValueNotifier<bool>(themeController.theThemeIsDark.value);

  // Listen to changes and toggle theme
  switchController.addListener(() {
    themeController.changeTheme();
  });
  return Obx(
    () => AdvancedSwitch(
      borderRadius: const BorderRadius.vertical(
          top: Radius.elliptical(30, 30), bottom: Radius.elliptical(30, 30)),
      thumb: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration:
            BoxDecoration(color: customColors.primary, shape: BoxShape.circle),
      ),
      height: 45,
      width: 70,
      controller: switchController,

      activeChild: themeController.theThemeIsDark.value
          ? darkModeIcon(themeController.theThemeIsDark.value, context)
          : lightModeIcon(themeController.theThemeIsDark.value, context),
      inactiveChild: !themeController.theThemeIsDark.value
          ? lightModeIcon(themeController.theThemeIsDark.value, context)
          : darkModeIcon(themeController.theThemeIsDark.value, context),
      activeColor:
          customColors.primaryBackground, //the background color of the moon
      inactiveColor:
          customColors.primaryBackground, //the background color of the sun
    ),
  );
}

Widget lightModeIcon(bool isDarkMode, BuildContext context) {
  return !isDarkMode
      ? Padding(
          padding: isRTL(context)
              ? const EdgeInsets.only(left: 70)
              : const EdgeInsets.only(right: 15),
          child: Icon(
            color: customColors.secondaryText,
            Icons.wb_sunny_rounded,
            size: 20,
          ),
        )
      : const SizedBox();
}

Widget darkModeIcon(bool isDarkMode, BuildContext context) {
  return isDarkMode
      ? Padding(
          padding: isRTL(context)
              ? const EdgeInsets.only(left: 5)
              : const EdgeInsets.only(left: 5),
          child: Icon(
            color: customColors.secondaryText,
            Icons.nightlight_round_outlined,
            size: 20,
          ),
        )
      : const SizedBox();
}

bool isRTL(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl;
