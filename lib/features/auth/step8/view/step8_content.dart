import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../core/utils/animation/animation_def.dart';
import '../../../../core/utils/animation/animation_util.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../controller/step8_controller.dart';
import 'widget/selected_list.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Step8Content extends StatelessWidget {
  Step8Content({super.key});
  Step8Controller step8controller = Get.put(Step8Controller());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(children: [
        Text(
          "Enter your location",
          textAlign: TextAlign.center,
          style: customTextStyle.titleMedium.override(
            fontFamily: 'BeerSerif',
            color: customColors.primaryText,
            fontSize: 16,
            useGoogleFonts: false,
          ),
        ).tr(),
        SizedBox(
          height: scaleHeight(12),
        ),
        Text(
          "Please enter where do you live",
          textAlign: TextAlign.center,
          style: customTextStyle.bodyMedium.override(
            fontFamily: 'BeerSerif',
            color: customColors.primaryText,
            fontSize: 14,
            letterSpacing: 0.2,
            fontWeight: FontWeight.normal,
            useGoogleFonts: false,
          ),
        ).tr(),
        SizedBox(
          height: scaleHeight(50),
        ),
        Image.asset(
          'assets/images/rafiki.png',
          height: 180,
          fit: BoxFit.contain,
        ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimationsteps']!),
        SizedBox(
          height: scaleHeight(50),
        ),
        InkWell(
          onTap: () async {
            await showButtonSheet(
                context: context, widget: SelectState(), height: 300);
          },
          child: GetBuilder<Step8Controller>(builder: (ccontext) {
            return Container(
              width: double.infinity,
              height: scaleHeight(50),
              padding: padding(0, 10, 0, 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: customColors.primaryBackground),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    step8controller.selectedState ??tr( "Select State"),
                    style: customTextStyle.bodyMedium,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: customColors.secondaryText,
                    size: 15,
                  )
                ],
              ),
            );
          }),
        ),
        buildButton()
      ]),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 0),
      child: Obx(
        ()=> Column(
          children: [
            ButtonWidget(
              showLoadingIndicator: step8controller.isLoading.value,
              onPressed: () async {
                step8controller.onPressContune();              },
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
            SizedBox(
              height: scaleHeight(5),
            ),
            ...List.generate(
                step8controller.errorMessage.length,
                (index) => ErrorMessages(
                      message: step8controller.errorMessage[index],
                    ))
          ],
        ),
      ),
    );
  }
}
