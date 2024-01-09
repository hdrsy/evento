import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/next_step_button.dart';
import 'package:evento/features/service_provider/see_all_service_category_profile_page/controller/see_all_service_category_controller.dart';
import 'package:evento/features/service_provider/see_all_service_category_profile_page/view/widget/service_card.dart';
import 'package:evento/features/service_provider/see_all_service_category_profile_page/view/widget/venue_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
         title: Text("Service Provider's",
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
                    const SeeAllServiceVenueCard(),
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
            const NextStepButton()
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
