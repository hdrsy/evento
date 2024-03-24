import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/organizer/show_all_booking_in_event_for_orgnaizer/controller/show_all_booking_in_event_for_organizer_controller.dart';
import 'package:evento/features/organizer/show_all_booking_in_event_for_orgnaizer/model/show_all_booking_in_event_for_organizer_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowAllBookingInEventForOrganizerScreen extends StatelessWidget {
  ShowAllBookingInEventForOrganizerScreen({super.key});
  final ShowAllBookingInEventForOrganizerController controller =
      Get.put(ShowAllBookingInEventForOrganizerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text(tr("Tickets"),
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: GestureDetector(
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
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: customColors.primary,
                  ),
                )
              : controller.itemList.isEmpty
                  ? EmptyData(
                      icon: Icons.people_rounded,
                      message:
                          "It looks like no one has confirmed attendance yet. Be the first to join!",
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      controller: controller.scrollController,
                      child: Column(
                        children: [
                          ...List.generate(
                              controller.hasMoreData.value
                                  ? controller.itemList.length + 1
                                  : controller.itemList.length, (index) {
                            return index < controller.itemList.length
                                ? GoingCard(
                                    goingModel: controller.itemList[index],
                                    modelId: index,
                                  )
                                : ShimmerLoadingWidget(
                                    loadingShimmerWidget: Container(
                                    width: double.infinity,
                                    height: screenHeight * 0.1,
                                    // height: 330 ,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: customColors.info,
                                        ),
                                        color: customColors.info),
                                  ));
                          })
                        ].divide(const SizedBox(
                          height: 10,
                        )),
                      ),
                    ),
        ));
  }
}

class GoingCard extends StatelessWidget {
  const GoingCard({super.key, required this.goingModel, required this.modelId});
  final ShowAllBookingInEventForOrganizerModel goingModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowAllBookingInEventForOrganizerController>(
        builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
          child: Container(
            width: screenHeight * 0.15,
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
            ),
            child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: goingModel.profile.length > 6
                            ? getImageNetwork(
                                url: "/storage/${goingModel.profile}",
                                width: 90,
                                height: 90)
                            : Image.asset(
                                'assets/images/${goingModel.profile}.png',
                                width: 90,
                                height: 90,
                              )),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          "${goingModel.firstName} ${goingModel.lastName}",
                          style: customTextStyle.bodyLarge,
                        ),
                      ),
                    ),
                    IconWithContainer(
                        iconColor: customColors.info,
                        onTap: () {
                          Get.toNamed(
                              '/BookingDetailesInEventForOrganizerScreen');
                        },
                        icon: Icons.info_outline,
                        buttonSize: 30.w,
                        borderRadius: 20.sp,
                        backgroundColor: customColors.primary)
                  ],
                )),
          ),
        ),
      );
    });
  }
}
