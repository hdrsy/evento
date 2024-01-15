import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import 'widget/male_female.dart';
import '../../steps/controller/page_controller.dart';
import '../../steps/controller/steps_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Step5Content extends StatelessWidget {
  Step5Content({super.key});
  StepsController stepsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Which one are you?",
            textAlign: TextAlign.center,
            style: customTextStyle.bodyMedium.copyWith(
              fontFamily: 'BeerSerif',
              color: customColors.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
          SizedBox(height: scaleHeight(50),),
          buildMainStack(context),
          SizedBox(height: scaleHeight(50),),
          Text(
            "To give you a customize experience we need to know your gender",
            textAlign: TextAlign.center,
            style: customTextStyle.bodyMedium.copyWith(
              fontFamily: 'BeerSerif',
              letterSpacing: 0.2,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ).tr(),
          buildButton()
        ],
      ),
    );
  }
   Widget buildButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 0),
      child: ButtonWidget(
        onPressed: () async {
          StepsPageController stepsPageController=Get.find();
          stepsPageController.pageIdex.value=6;
        },
        text:tr( "Continue"),
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
