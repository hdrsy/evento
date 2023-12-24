import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/next_step_button.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/service_card.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/slider.dart';
import 'package:evento/features/customize_event/service_category/view/widgets/step_text.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceCategoryScreen extends StatelessWidget {
  const ServiceCategoryScreen({super.key});

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
      body: SingleChildScrollView(
        padding: padding(16, 16, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepText3(),
            const LinearPercentIndicatorWidget(),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Text(
                "Customize Your Event",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  fontSize: 18,
                  useGoogleFonts: false,
                ),
              ),
            ),
            const ServiceCard(),
            const ServiceCard(),
            const ServiceCard(),
            const ServiceCard(),
            const ServiceCard(),
            const ServiceCard(),
            const NextStepButton()
          ].divide(SizedBox(
            height: scaleHeight(15),
          )).addToEnd(const SizedBox(height: 15,)),
        ),
      ),
    );
  }
}
