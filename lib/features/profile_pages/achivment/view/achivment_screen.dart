import '../../../../core/utils/theme/text_theme.dart';
import 'widgets/achievement_list.dart';
import 'widgets/couponse_list.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AchivmentScreen extends StatelessWidget {
  const AchivmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body:  SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: const Alignment(0, 0),
                        child: TabBar(
                          labelColor: customColors.primary,
                          unselectedLabelColor: customColors.grayIcon,
                          labelStyle: customTextStyle.titleSmall.override(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: true,
                          ),
                          unselectedLabelStyle: const TextStyle(),
                          indicatorColor: customColors.primary,
                          indicatorWeight: 4,
                          tabs: const [
                            Tab(
                              text: "Couponse",
                            ),
                            Tab(
                              text: "Achievements",
                            ),
                           
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [
                          CouponseList(),
                          AchievementList(),
                        
                         ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      );
 
  }
}