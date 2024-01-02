import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/service_category/controller/service_category_controller.dart';
import 'package:evento/features/customize_event/service_category/model/service_category_model.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/next_step_button.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/service_card.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/slider.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/step_text.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/venue_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceCategoryScreen extends StatelessWidget {
  ServiceCategoryScreen({super.key});
  final ServiceCategoryController serviceCategoryController = Get.find();
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepText3(),
            const LinearPercentIndicatorWidget(),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                "Customize Your Event",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: primaryFontFamily,
                  color: customColors.primaryText,
                  fontSize: 18,
                  useGoogleFonts: true,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Selected",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: primaryFontFamily,
                      color: customColors.primaryText,
                      fontSize: 12,
                      useGoogleFonts: true,
                    ),
                  ),
                  GetBuilder<ServiceCategoryController>(
                    builder: (context) {
                      return Text(
                        "${serviceCategoryController.selectedServiceProvidersNumbers()}/${serviceCategoryController.serviceCategoryList.length + 1}",
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: primaryFontFamily,
                          color: customColors.primaryText,
                          fontSize: 12,
                          useGoogleFonts: true,
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
           
            Obx(
              () => Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                     const VenueCard(),
                    ...List.generate(
                      serviceCategoryController.serviceCategoryList.length,
                      (index) => ServiceCard(
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
