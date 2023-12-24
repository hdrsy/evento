import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/auth/step7/controller/step7_controller.dart';
import 'package:evento/features/auth/step7/view/widgets/interests_grid_view.dart';
import 'package:evento/features/auth/step7/view/widgets/interests_shimmer.dart';
import 'package:evento/features/auth/steps/controller/page_controller.dart';
import 'package:evento/features/auth/steps/controller/steps_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Step7Content extends StatelessWidget {
  Step7Content({super.key});
  StepsController stepsController = Get.find();
  Step7Controller step7controller=Get.put(Step7Controller());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ),
        ),
        SizedBox(
height: scaleHeight(400),
          child: 
          
          Obx(()=>step7controller.isLoading.value?interestShimmerGridView() :MyGridView())),
          buildButton()
      ],),
    );
  }
    Widget buildButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 0),
      child: ButtonWidget(
        onPressed: () async {
          StepsPageController stepsPageController=Get.find();
for (var i = 0; i < step7controller.selectedInterests.length; i++) {
  if(step7controller.selectedInterests[i].value){
    stepsController.interestList.add(step7controller.allInterestItem[i]);
  }
}
          stepsPageController.pageIdex.value = 8;
        },
        text: "Continue",
        options: ButtonOptions(
          width: scaleWidth(330),
          height: scaleHeight(40),
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
