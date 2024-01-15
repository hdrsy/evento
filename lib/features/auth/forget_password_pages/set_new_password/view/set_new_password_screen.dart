import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/functions/validation/password_validation.dart';
import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../../core/shared/widgets/text_fields/text_field.dart';
import '../../../../../core/utils/animation/animation_def.dart';
import '../../../../../core/utils/animation/animation_util.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../main.dart';
import '../controller/set_new_password_controller.dart';
import 'package:easy_localization/easy_localization.dart';

class SetNewPasswordScreen extends StatelessWidget {
   SetNewPasswordScreen({super.key});
final SetNewPasswordController setNewPasswordController=Get.put(SetNewPasswordController());
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
key: setNewPasswordController.formstate,
          child: SingleChildScrollView(
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
              ).tr(),
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
              ).tr(),
              SizedBox(
                height: scaleHeight(50),
              ),
              Image.asset(
                'assets/images/pana.png',
                height: 180,
                fit: BoxFit.contain,
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimationsteps']!),
              customTextField(
                  context: context,
                  label:tr( "New Password"),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setNewPasswordController.newPassword.text=value!;
                  },
                  validator: (value) {
                    return passwordValidation(value);
                  },
                  isPassWordVisible: false),
              
              customTextField(
                  context: context,
                  label:tr( "Confirm Password"),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setNewPasswordController.confPassword.text=value!;
                  },
                  validator: (value) {
                return   setNewPasswordController.confPassword.text==setNewPasswordController.newPassword.text?null:"The confirm password doesn't mathcing the new password";
                   
                  },
                  isPassWordVisible: false),
              
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
setNewPasswordController.onPressContinue();              },
              text:tr( "Continue"),
              showLoadingIndicator: setNewPasswordController.isLoading.value,
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
              setNewPasswordController.errorMessage.length,
              (index) => ErrorMessages(
                    message: setNewPasswordController.errorMessage[index],
                  )),
        ],
      ),
    );
  }
}
