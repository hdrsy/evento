import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/events/see_all/controller/see_all_controller.dart';
import 'package:evento/features/events/see_all/view/widgets/see_all_card.dart';
import 'package:evento/main.dart';
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    SeeAllController seeAllController = Get.find();
    return SingleChildScrollView(
      controller: seeAllController.scrollController,
      padding: padding(16, 16, 16, 16),
      child: Obx(
        ()=> Column(
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
                  : ShimmerLoadingWidget(
                      loadingShimmerWidget: Container(
                      width: 355,
                      height: 300,
                      // height: 330 ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: customColors.info,
                          ),
                          color: customColors.info),
                    ));
            })
          ].divide(SizedBox(
            height: scaleHeight(15),
          )),
        ),
      ),
    );
  }
}
