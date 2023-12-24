import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/functions/validation/password_validation.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/text_fields/text_field.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/features/auth/steps/controller/page_controller.dart';
import 'package:evento/features/auth/steps/controller/steps_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Step2Content extends StatelessWidget {
   Step2Content({super.key});
StepsController stepsController=Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Form(
        key: stepsController.passwordformstate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Set your password",
              textAlign: TextAlign.center,
              style: customTextStyle.titleMedium.copyWith(
                fontFamily: 'BeerSerif',
                fontSize: 16,
                color: customColors.primaryText,
              ),
            ),
            SizedBox(
              height: scaleHeight(12),
            ),
            Text(
              "Enter a strong password for your account",
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.copyWith(
                fontFamily: 'BeerSerif',
                color: customColors.primaryText,
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: scaleHeight(50),
            ),
            Image.asset(
              'assets/images/pana.png',
              height: 180,
              fit: BoxFit.contain,
            ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimationsteps']!),
            Container(

                margin: EdgeInsets.symmetric(vertical: scaleHeight(48)),

                child: customTextField(
                    context: context,
                    label: "Enter Password",
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      stepsController.password.text=value!;
                    },
                    validator: (value) {
                      return passwordValidation(value);
                    },
                    isPassWordVisible: false)),
            buildButton()
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 0),
      child: ButtonWidget(
        showLoadingIndicator: false,
        onPressed: () async {
          FormState? formdata = stepsController.passwordformstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
          StepsPageController stepsPageController=Get.find();
          stepsPageController.pageIdex.value=3;
        }},
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
