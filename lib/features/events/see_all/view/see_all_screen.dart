import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/utils/animation/shimmer_animation.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/see_all_controller.dart';
import 'widgets/see_all_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllScreen extends StatelessWidget {
  SeeAllScreen({super.key});
  final SeeAllController seeAllController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(seeAllController.pageTitle,
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    SeeAllController seeAllController = Get.find();
    return Obx(
      () => seeAllController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: customColors.primary,
              ),
            )
          : seeAllController.itemList.isEmpty
              ? const EmptyData(
                  icon: Icons.replay_circle_filled_outlined,
                  message:
                      "Looks like there are no  events available right now - check back later!")
              : SingleChildScrollView(
                  controller: seeAllController.scrollController,
                  padding: padding(16, 16, 16, 16),
                  child: Column(
                    children: [
                      ...List.generate(
                          seeAllController.hasMoreData.value
                              ? seeAllController.itemList.length + 1
                              : seeAllController.itemList.length, (index) {
                        return index < seeAllController.itemList.length
                            ? SeeAllCard(
                                eventModel: seeAllController.itemList[index],
                                modelIndex: index,
                              )
                            : seeAllController.isLoadingMoreData.value
                                ? ShimmerLoadingWidget(
                                    loadingShimmerWidget: Container(
                                    width: 355,
                                    height: 100,
                                    // height: 330 ,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: customColors.info,
                                        ),
                                        color: customColors.info),
                                  ))
                                : SizedBox();
                      })
                    ].divide(SizedBox(
                      height: scaleHeight(15),
                    )),
                  ),
                ),
    );
  }
}
