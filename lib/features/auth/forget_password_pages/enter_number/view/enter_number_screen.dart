import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/functions/validation/phone_validation.dart';
import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../../core/shared/widgets/text_fields/text_field.dart';
import '../../../../../core/utils/animation/animation_def.dart';
import '../../../../../core/utils/animation/animation_util.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../controller/enter_number_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterNumberScreen extends StatelessWidget {
  EnterNumberScreen({super.key});
  final EnterNumberController enterNumberController = Get.put(EnterNumberController());
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter your number",
                textAlign: TextAlign.center,
                style: customTextStyle.titleMedium,
              ).tr(),
              Text(
                " Please enter a valid number to...",
                textAlign: TextAlign.center,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: secondaryFontFamily,
                  fontSize: 14,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.normal,
                  useGoogleFonts: true,
                ),
              ).tr(),
              SizedBox(
                  height: scaleHeight(50),
                ),
              Image.asset(
                'assets/images/cuate.png',
                height: 180,
                fit: BoxFit.contain,
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
              SizedBox(
                  height: scaleHeight(60),
                ),
              Form(
                key: enterNumberController.formstate,
                child: customTextField(
                  context: context,
                  label:tr( "+963    mobile Phone"),
                  onChanged: (value) {
                     if (value != null && !value.startsWith('0') && value.isNotEmpty) {
      // Prepend '0' if it's not already there and the value is not empty
      enterNumberController.phone.text = '0$value';
    } else {
      enterNumberController.phone.text = value!;
    }
                  },
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return phoneValidation(value);
                  },
                ),
              ),
              
              buildButton()
            ].divide(const SizedBox(height: 16,)),
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
                enterNumberController.onPressContinue();
              },
              text:tr( "Continue"),
              showLoadingIndicator: false,
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
              enterNumberController.errorMessage.length,
              (index) => ErrorMessages(
                    message: enterNumberController.errorMessage[index],
                  )),
        ],
      ),
    );
  }
}
