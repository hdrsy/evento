import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';

import '../controller/service_category_controller.dart';
import 'widgets/next_step_button.dart';
import 'widgets/service_card.dart';
import 'widgets/slider.dart';
import 'widgets/step_text.dart';
import 'widgets/venue_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

////"From vision to reality: Choose your event theme with our experts and create something extraordinary."
class ServiceCategoryScreen extends StatelessWidget {
  ServiceCategoryScreen({super.key});
  final ServiceCategoryController serviceCategoryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        surfaceTintColor: customColors.secondaryBackground,
        title: Text(tr("Customize Your Event"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
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
                "From vision to reality",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: primaryFontFamily,
                  color: customColors.primaryText,
                  fontSize: 18,
                  useGoogleFonts: true,
                ),
              ).tr(),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                "Choose your event theme with our experts and create something extraordinary.",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: primaryFontFamily,
                  color: customColors.primaryText,
                  fontSize: 14,
                  useGoogleFonts: true,
                ),
                textAlign: TextAlign.center,
              ).tr(),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      "${serviceCategoryController.selectedServiceProvidersNumbers()} ${tr("Selected")}",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: primaryFontFamily,
                        color: customColors.primaryText,
                        fontSize: 12,
                        useGoogleFonts: true,
                      ),
                    ).tr(),
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
                height: scaleHeight(5),
              ))
              .addToEnd(const SizedBox(
                height: 15,
              )),
        ),
      ),
    );
  }
}
