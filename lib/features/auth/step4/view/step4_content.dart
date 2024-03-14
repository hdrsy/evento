import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/utils/animation/animation_def.dart';
import '../../../../core/utils/animation/animation_util.dart';
import 'widget/notification_types_text.dart';
import '../../steps/controller/page_controller.dart';
import '../../steps/controller/steps_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Step4Content extends StatelessWidget {
  Step4Content({super.key});
  StepsController stepsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Do you want to turn on notification?",
            textAlign: TextAlign.center,
            style: customTextStyle.bodyMedium.copyWith(
              fontFamily: 'BeerSerif',
              color: customColors.primaryText,
              fontSize: 14,
            ),
          ).tr(),
          SizedBox(
            height: scaleHeight(50),
          ),
          // Generated code for this Image Widget...
          Image.asset(
            'assets/images/pana.png',
            height: 180,
            fit: BoxFit.contain,
          ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimationsteps']!),
          SizedBox(
            height: scaleHeight(50),
          ),
          const NotificationTypesText(),
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
          // stepsController.turnOnNotification=true;
          await stepsController.requestNotificationPermission()
              ? stepsPageController.pageIdex.value = 5
              : null;
        },
        text: tr("Activate"),
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
