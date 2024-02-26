import '../../../../core/responsive/responsive.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/see_all_service_category_controller.dart';
import 'widget/service_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class SeeAllServiceCategoryScreen extends StatelessWidget {
  SeeAllServiceCategoryScreen({super.key});
  final SeeAllServiceCategoryController serviceCategoryController =
      Get.put(SeeAllServiceCategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Service Provider's"),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    // const SeeAllServiceVenueCard(),
                    ...List.generate(
                      serviceCategoryController.serviceCategoryList.length,
                      (index) => SeeAllServiceCard(
                        serviceCategoryModel: serviceCategoryController
                            .serviceCategoryList[index],
                        serviceCategoryIndex: index,
                      ),
                    ),
                  ].divide(
                    SizedBox(height: scaleHeight(15)),
                  ),
                ),
              )),
            ),
            // const NextStepButton()
          ]
              .divide(SizedBox(
                height: scaleHeight(15),
              ))
              .addToEnd(const SizedBox(
                height: 15,
              )),
        ),
      ),
    );
  }
}
