import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../core/utils/theme/theme_controller.dart';
import '../../../../main_bottom_navigation_bar/controller/main_bottom_navigation_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class ThemeSwicth extends StatelessWidget {
  ThemeSwicth({super.key});
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            tr("Account"),
            style: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: customColors.primaryText,
              fontWeight: FontWeight.normal,
              useGoogleFonts: true,
            ),
          ),
        ),
        // const ThemeToggleSwitch()
        themeSwitcher()
      ],
    );
  }
}

Widget themeSwitcher() {
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

      activeChild: activeChild(themeController.theThemeIsDark.value),
      inactiveChild: inactiveChild(themeController.theThemeIsDark.value),
      activeColor:
          customColors.primaryBackground, //the background color of the moon
      inactiveColor:
          customColors.primaryBackground, //the background color of the sun
    ),
  );
}

Widget inactiveChild(bool isDarkMode) {
  return !isDarkMode
      ? Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            color: customColors.secondaryText,
            Icons.wb_sunny_rounded,
            size: 20,
          ),
        )
      : const SizedBox();
}

Widget activeChild(bool isDarkMode) {
  return isDarkMode
      ? Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(
            color: customColors.secondaryText,
            Icons.nightlight_round_outlined,
            size: 20,
          ),
        )
      : const SizedBox();
}

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming 'isDarkMode' is a reactive variable in your ThemeController
    // that determines the current theme mode.
    final ThemeController themeController = Get.find<ThemeController>();

    return Container(
      padding: padding(0, 1, 0, 1),
      width: 70,
      child: Obx(() => AnimatedToggleSwitch<bool>.dual(
            current: themeController.theThemeIsDark.value,
            first: false,
            second: true,
            borderWidth: 0,
            height: 40,
            spacing: 0,
            onChanged: (isDarkMode) async {
              await themeController.changeTheme(); // Trigger the theme change
            },
            style: ToggleStyle(indicatorColor: customColors.primary),
            textBuilder: (value) => value
                ? Icon(Icons.dark_mode, color: customColors.secondaryText)
                : Icon(Icons.light_mode, color: customColors.secondaryText),
          )),
    );
  }
}
