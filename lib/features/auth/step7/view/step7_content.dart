import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../controller/step7_controller.dart';
import 'widgets/interests_grid_view.dart';
import 'widgets/interests_shimmer.dart';
import '../../steps/controller/page_controller.dart';
import '../../steps/controller/steps_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Step7Content extends StatelessWidget {
  Step7Content({super.key});
  StepsController stepsController = Get.find();
  Step7Controller step7controller = Get.put(Step7Controller());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Text(
              "Time to customize your interest",
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'BeerSerif',
                color: customColors.primaryText,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.2,
                useGoogleFonts: false,
              ),
            ).tr(),
          ),
          SizedBox(
              height: scaleHeight(400.h),
              child: Obx(() => step7controller.isLoading.value
                  ? interestShimmerGridView()
                  : MyGridView())),
          buildButton()
        ],
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
      child: ButtonWidget(
        onPressed: () async {
          StepsPageController stepsPageController = Get.find();
          for (var i = 0; i < step7controller.selectedInterests.length; i++) {
            if (step7controller.selectedInterests[i].value) {
              stepsController.interestList
                  .add(step7controller.allInterestItem[i]);
            }
          }
          stepsPageController.pageIdex.value = 8;
        },
        text: tr("Continue"),
        options: ButtonOptions(
          width: 350,
          height: 45,
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: customColors.primary,
          textStyle: customTextStyle.titleSmall.copyWith(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          elevation: 0,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
