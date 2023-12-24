import 'package:evento/core/utils/extenstions/color_extenstions.dart';
import 'package:evento/core/utils/extenstions/text_extenstions.dart';
import 'package:evento/features/main_bottom_navigation_bar/controller/main_bottom_navigation_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavigationBarWidget extends StatelessWidget {
   MainBottomNavigationBarWidget({super.key});
final MainBottomNavigationController mainBottomNavigationController=Get.find();
  @override
  Widget build(BuildContext context) {
       customColors = Theme.of(context).extension<AppColorsExtension>()!;
    customTextStyle = Theme.of(context).extension<TextExtension>()!;
 
    return Obx(() =>  Scaffold(
      body:mainBottomNavigationController.screens[mainBottomNavigationController.selectedPage.value] ,
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: mainBottomNavigationController.selectedPage.value,
        onTap: (i) => mainBottomNavigationController.changePage(i),
        backgroundColor: customColors.secondaryBackground,
        selectedItemColor: customColors.primary,
        unselectedItemColor: customColors.grayIcon,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 24.0,
            ),
            label: "Home",
            tooltip: '',
          ),
           BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 20.0,
            ),
            activeIcon: Icon(
              Icons.search_sharp,
              size: 24.0,
            ),
            label:  "search",
            tooltip: '',
          ),
      
          BottomNavigationBarItem(
            icon: Icon(
              Icons.slow_motion_video_outlined,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.slow_motion_video,
              size: 24.0,
            ),
            label:  "Reels",
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.auto_awesome_outlined,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.auto_awesome_sharp,
              size: 24.0,
            ),
            label:  "Customize",
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              size: 24.0,
            ),
            label: "Profile",
            tooltip: '',
          )
        ],
      ),
    ));
  }
}