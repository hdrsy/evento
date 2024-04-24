import 'package:evento/core/responsive/size_config.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/extenstions/color_extenstions.dart';
import '../../../core/utils/extenstions/text_extenstions.dart';
import '../controller/main_bottom_navigation_controller.dart';
import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class MainBottomNavigationBarWidget extends StatelessWidget {
  MainBottomNavigationBarWidget({super.key});
  final MainBottomNavigationController mainBottomNavigationController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    customColors = Theme.of(context).extension<AppColorsExtension>()!;
    customTextStyle = Theme.of(context).extension<TextExtension>()!;
    SizeConfig().init(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (popHandled) {
        // Check if the pop event has not been handled and the current index is not the home page
        if (mainBottomNavigationController.selectedPage.value != 0) {
          // Change to the home page index
          mainBottomNavigationController.changePage(0);
        } else {
          if (isGuset) {
            Get.offAllNamed('/');
          } else {
            SystemNavigator.pop();
          }
        }
      },
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(() => Scaffold(
              body: mainBottomNavigationController
                  .getScreen(mainBottomNavigationController.selectedPage.value),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: mainBottomNavigationController.selectedPage.value,
                onTap: (i) => mainBottomNavigationController.changePage(i),
                backgroundColor:
                    mainBottomNavigationController.selectedPage.value == 2
                        ? Colors.black
                        : customColors.secondaryBackground,
                selectedItemColor: customColors.primary,
                unselectedItemColor: customColors.grayIcon,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.home_outlined,
                      size: 24.0,
                    ),
                    activeIcon: const Icon(
                      Icons.home,
                      size: 24.0,
                    ),
                    label: tr("Home"),
                    tooltip: '',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.search,
                      size: 20.0,
                    ),
                    activeIcon: const Icon(
                      Icons.search_sharp,
                      size: 24.0,
                    ),
                    label: tr("search"),
                    tooltip: '',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.slow_motion_video_outlined,
                      size: 24.0,
                    ),
                    activeIcon: const Icon(
                      Icons.slow_motion_video,
                      size: 24.0,
                    ),
                    label: tr("Reels"),
                    tooltip: '',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.auto_awesome_outlined,
                      size: 24.0,
                    ),
                    activeIcon: const Icon(
                      Icons.auto_awesome_sharp,
                      size: 24.0,
                    ),
                    label: tr("Customize"),
                    tooltip: '',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 24.0,
                    ),
                    activeIcon: const Icon(
                      Icons.account_circle,
                      size: 24.0,
                    ),
                    label: tr("Profile"),
                    tooltip: '',
                  )
                ],
              ),
            )),
      ),
    );
  }
}
