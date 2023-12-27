  import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/functions/validation/pin.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/error_messages/error_messages.dart';
import 'package:evento/core/shared/widgets/text_fields/pin.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/auth/forget_password_pages/verify_forget_password/controller/verify_forget_password_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyForgetPasswordScreen extends StatelessWidget {
  VerifyForgetPasswordScreen({super.key});
  final VerifyForgetPasswordController verifyForgetPasswordController = Get.put(VerifyForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        leading: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: customColors.primaryText,
            size: 24,
          ),
          onTap: () async {
            Get.back();
          },
        ),
        elevation: 0.0,
        backgroundColor: customColors.secondaryBackground,
      ),
      body: Container(
         padding:  padding(15,24,24,24),
       
        width: double.infinity,
        child: Form(
          key: verifyForgetPasswordController.formstate,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "We’ll text you on ${verifyForgetPasswordController.phone}.",
                    textAlign: TextAlign.center,
                    style: customTextStyle.bodyMedium.copyWith(
                      fontFamily: 'BeerSerif',
                      color: customColors.primaryText,
                      fontSize: 16,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: scaleHeight(50),
                  ),
                  Image.asset(
                    'assets/images/rafiki.png',
                    height: scaleHeight(180),
                    fit: BoxFit.contain,
                  ).animateOnPageLoad(
                      animationsMap['imageOnPageLoadAnimationsteps']!),
                  SizedBox(
                    height: scaleHeight(12),
                  ),
                  Pin(
                  
                    onChanged: (value) {
                      verifyForgetPasswordController.pin.text = value;
                    },
                    textEditingController: verifyForgetPasswordController.pin,
                    validator: (value) {
                      return pinValidation(value);
                    },
                  ),
                  Text(
                    "Send me a new code",
                    style: customTextStyle.bodyMedium.copyWith(
                      fontFamily: 'BeerSerif',
                      color: customColors.primaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: scaleHeight(50),
                  ),
                  
                buildButton()
              ].divide(const SizedBox(height: 16,)),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 0),
            child: ButtonWidget(
              onPressed: () async {
                verifyForgetPasswordController.onPressContinue();
              },
              text: "Continue",
              showLoadingIndicator: verifyForgetPasswordController.isLoading.value,
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
          ),
          SizedBox(
            height: scaleHeight(5),
          ),
          ...List.generate(
              verifyForgetPasswordController.errorMessage.length,
              (index) => ErrorMessages(
                    message: verifyForgetPasswordController.errorMessage[index],
                  )),
        ],
      ),
    );
  }
}
