import '../../../../core/responsive/responsive.dart';
import '../../step1/view/step1_screen.dart';
import '../../step2/view/step2_content.dart';
import '../../step3/view/step3_content.dart';
import '../../step5/view/step5_content.dart';
import '../../step6/view/step6_content.dart';
import '../../step7/view/step7_content.dart';
import '../../step8/view/step8_content.dart';
import '../controller/page_controller.dart';
import 'widgets/app_bar_with_percent.dart';
import 'widgets/steps_text.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MainStepsScreen extends StatelessWidget {
  MainStepsScreen({super.key});
  StepsPageController pageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: customColors.secondaryBackground,
          appBar: buildAppBarWithLineIndicatorincenter(
              pageController.pageIdex.value / 7, pageController.pageIdex.value),
          body: Padding(
            padding: padding(0, 24, 24, 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StepsText(
                    pageIdex: pageController.pageIdex.value,
                  ),
                  SizedBox(
                    height: scaleHeight(12),
                  ),
                  getCenterContent(pageController.pageIdex.value),
                ],
              ),
            ),
          )),
    );
  }
}

Widget getCenterContent(int index) {
  switch (index) {
    case 1:
      return Step1Screen();
    case 2:
      return Step2Content();
    case 3:
      return Step3Content();
    case 4:
      return Step5Content();
    case 5:
      return Step6Content();
    case 6:
      return Step7Content();
    case 7:
      return Step8Content();

    default:
      return Step1Screen();
  }
}
