import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../core/utils/animation/animation_def.dart';
import '../../../../core/utils/animation/animation_util.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/text_theme.dart';
import 'widgets/build_day_month_year.dart';
import '../../steps/controller/page_controller.dart';
import '../../steps/controller/steps_controller.dart';
import '../../../../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Step3Content extends StatelessWidget {
  Step3Content({super.key});
  StepsController stepsController = Get.find();
  DateTime selectedDate =
      DateTime.now().subtract(const Duration(days: 365 * 12 + 3));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Set your date of birth",
            textAlign: TextAlign.center,
            style: customTextStyle.titleMedium.copyWith(
                fontFamily: 'BeerSerif',
                color: customColors.primaryText,
                fontSize: 16),
          ).tr(),
          SizedBox(
            height: scaleHeight(12),
          ),
          Text(
            "Enter a real date of birth.",
            textAlign: TextAlign.center,
            style: customTextStyle.bodyMedium.copyWith(
              fontFamily: 'BeerSerif',
              fontSize: 14,
              letterSpacing: 0.2,
              fontWeight: FontWeight.normal,
            ),
          ).tr(),
          SizedBox(
            height: scaleHeight(50),
          ),
          Image.asset(
            'assets/images/bro.png',
            height: 180,
            fit: BoxFit.contain,
          ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimationsteps']!),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(48, 48, 48, 0),
            child: Container(
              width: scaleWidth(300),
              height: scaleHeight(45),
              padding: padding(0, 10, 0, 10),
              decoration: BoxDecoration(
                color: customColors.primaryBackground,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: customColors.primaryBackground,
                ),
              ),
              alignment: const AlignmentDirectional(0.00, 0.00),
              child: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (_) => Container(
                            padding: padding(10, 0, 20, 0),
                            height: 300,
                            decoration: BoxDecoration(
                              color: customColors.secondaryBackground,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: CupertinoTheme(
                                    data: CupertinoThemeData(
                                      textTheme: CupertinoTextThemeData(
                                        dateTimePickerTextStyle: TextStyle(
                                            color: customColors.secondaryText,
                                            fontSize: 20),
                                        pickerTextStyle: TextStyle(
                                            color: customColors.secondaryText),
                                      ),
                                    ),
                                    child: CupertinoDatePicker(
                                      initialDateTime: stepsController.day ??
                                          DateTime.now().subtract(
                                              const Duration(
                                                  days: 365 * 12 + 3)),
                                      mode: CupertinoDatePickerMode.date,
                                      minimumDate: DateTime(
                                          1950), // Assuming you want to allow dates back to 1800
                                      maximumDate: DateTime.now().subtract(
                                          const Duration(
                                              days: 365 * 12 +
                                                  3)), // 12 years and 3 days ago to account for leap years

                                      onDateTimeChanged: (val) {
                                        selectedDate = val;
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ButtonWidget(
                                      // showLoadingIndicator: false,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      text: tr("Cancel"),
                                      options: ButtonOptions(
                                        width: 120,
                                        height: 45,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(20, 0, 20, 0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 0),
                                        color: customColors.secondaryBackground,
                                        textStyle:
                                            customTextStyle.titleSmall.override(
                                          fontFamily: 'BeerSerif',
                                          color: customColors.primaryText,
                                          fontSize: 14,
                                          useGoogleFonts: false,
                                        ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: customColors.primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    ButtonWidget(
                                      onPressed: () {
                                        stepsController.day = selectedDate;
                                        stepsController.update();
                                        Get.back();
                                      },
                                      text: tr("Done"),
                                      options: ButtonOptions(
                                        width: 120,
                                        height: 45,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(20, 0, 20, 0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 0),
                                        color: customColors.primary,
                                        textStyle:
                                            customTextStyle.titleSmall.override(
                                          fontFamily: 'BeerSerif',
                                          color: customColors.info,
                                          fontSize: 14,
                                          useGoogleFonts: false,
                                        ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: customColors.primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ));
                },
                child: GetBuilder<StepsController>(builder: (context) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      DayMonthYear(
                        value: stepsController.day != null
                            ? DateFormat.MMMM().format(stepsController.day!)
                            : tr("Month"),
                      ),
                      DayMonthYear(
                        value: stepsController.day != null
                            ? DateFormat.d().format(stepsController.day!)
                            : tr("Day"),
                      ),
                      DayMonthYear(
                        value: stepsController.day != null
                            ? DateFormat.y().format(stepsController.day!)
                            : tr("Year"),
                      ),
                    ].divide(const Spacer()),
                  );
                }),
              ),
            ),
          ),
          buildButton()
        ],
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 0),
      child: Obx(
        () => Column(
          children: [
            ButtonWidget(
              showLoadingIndicator: false,
              onPressed: () async {
                if (stepsController.day != null) {
                  StepsPageController stepsPageController = Get.find();
                  stepsPageController.pageIdex.value = 4;
                } else {
                  stepsController.dateErrorMessage.value =
                      tr("Please select your birthday first");
                }
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
            SizedBox(
              height: scaleHeight(5),
            ),
            stepsController.dateErrorMessage.value != ''
                ? ErrorMessages(
                    message: stepsController.dateErrorMessage.value,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
