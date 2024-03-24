import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/features/profile_pages/achivment/controller/achivment_controller.dart';

import 'widgets/couponse_list.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AchivmentScreen extends StatelessWidget {
  AchivmentScreen({super.key});
  final AchivmentController achivmentController =
      Get.put(AchivmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Obx(
        () => SafeArea(
          top: true,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: achivmentController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: customColors.primary,
                      ),
                    )
                  : achivmentController.isError.value
                      ? EmptyData(
                          icon: Icons.error_outline_outlined,
                          message: "SomeThing Wrong!!",
                        )
                      : achivmentController.notificationList.isEmpty
                          ? EmptyData(
                              icon: Icons.discount_outlined,
                              message:
                                  "No current coupons. Exclusive offers will be featured here as they're available.",
                            )
                          : CouponseList()

              // DefaultTabController(
              //   length: 2,
              //   child: Column(
              //     mainAxisSize: MainAxisSize.max,
              //     children: [
              //       Expanded(
              //         child: Column(
              //           children: [
              //             Align(
              //               alignment: const Alignment(0, 0),
              //               child: TabBar(
              //                 labelColor: customColors.primary,
              //                 unselectedLabelColor: customColors.grayIcon,
              //                 labelStyle: customTextStyle.titleSmall.override(
              //                   fontFamily: 'Nunito',
              //                   fontWeight: FontWeight.w500,
              //                   useGoogleFonts: true,
              //                 ),
              //                 unselectedLabelStyle: const TextStyle(),
              //                 indicatorColor: customColors.primary,
              //                 indicatorWeight: 4,
              //                 tabs: const [
              //                   Tab(
              //                     text: "Couponse",
              //                   ),
              //                   Tab(
              //                     text: "Achievements",
              //                   ),

              //                 ],
              //               ),
              //             ),
              //             Expanded(
              //                 child: TabBarView(
              //               children: [
              //                 CouponseList(),
              //                 AchievementList(),

              //                ],
              //             ))
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              ),
        ),
      ),
    );
  }
}
