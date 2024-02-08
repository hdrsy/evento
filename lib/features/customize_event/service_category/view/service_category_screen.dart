import '../../../../core/responsive/responsive.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../controller/service_category_controller.dart';
import 'widgets/next_step_button.dart';
import 'widgets/service_card.dart';
import 'widgets/slider.dart';
import 'widgets/step_text.dart';
import 'widgets/venue_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              ).tr(),
            ),
            SizedBox(
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
                  ).tr(),
                  Obx(
                    () => Text(
                      "${serviceCategoryController.selectedServiceProvidersNumbers()}/${serviceCategoryController.serviceCategoryList.length + 1}",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: primaryFontFamily,
                        color: customColors.primaryText,
                        fontSize: 12,
                        useGoogleFonts: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    VenueCard(),
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
