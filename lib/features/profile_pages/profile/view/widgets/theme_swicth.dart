import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/core/utils/theme/theme_controller.dart';
import 'package:evento/features/main_bottom_navigation_bar/controller/main_bottom_navigation_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            "Account",
            style: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: customColors.primaryText,
              fontWeight: FontWeight.normal,
              useGoogleFonts: true,
            ),
          ),
        ),
        const ThemeToggleSwitch()
      ],
    );
  }
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
              MainBottomNavigationController mainBottomNavigationController =
                  Get.find();
              await themeController.changeTheme(); // Trigger the theme change
              mainBottomNavigationController.changePage(0);

              Future.delayed(const Duration(milliseconds: 15)).then((value) {
                mainBottomNavigationController.changePage(4);
              });
            },
            style: ToggleStyle(indicatorColor: customColors.primary),
            textBuilder: (value) => value
                ? Icon(Icons.dark_mode, color: customColors.secondaryText)
                : Icon(Icons.light_mode, color: customColors.secondaryText),
          )),
    );
  }
}
