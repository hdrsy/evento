import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/functions/validation/pin.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../core/shared/widgets/text_fields/pin.dart';
import '../../../../core/utils/animation/animation_def.dart';
import '../../../../core/utils/animation/animation_util.dart';
import '../controller/step1_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Step1Screen extends StatelessWidget {
  Step1Screen({super.key});
  Step1Controller step1controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: step1controller.formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "We’ll text you on ${step1controller.phone}.",
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
              Text(
                "Send me a new code",
                style: customTextStyle.bodyMedium.copyWith(
                  fontFamily: 'BeerSerif',
                  color: customColors.primaryText,
                  fontWeight: FontWeight.w500,
                ),
              ).tr(),
              SizedBox(
                height: scaleHeight(50),
              ),
              Pin(
              
                onChanged: (value) {
                  step1controller.pin.text = value;
                },
                textEditingController: step1controller.pin,
                validator: (value) {
                  return pinValidation(value);
                },
              ),
              buildButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Obx(
      ()=> Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 0),
            child: ButtonWidget(
              onPressed: () async {
                step1controller.onPressContinue();
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
           SizedBox(height: scaleHeight(5),),
                         ...List.generate(step1controller.errorMessage.length,(index)=>
                            
                            ErrorMessages(message:step1controller.errorMessage[index] ,)
                          ),
        ],
      ),
    );
  }
}
