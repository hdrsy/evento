import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextStepButton extends StatelessWidget {
  const NextStepButton({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Button Widget...
ButtonWidget(
  onPressed: () async {
Get.toNamed('/EventReviewScreen');
  },
  text: "Next ",
  options: ButtonOptions(
    height: 40,
    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    color: customColors.primary,
    textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          color: customColors.info,
          fontWeight: FontWeight.w500,
          useGoogleFonts: false,
        ),
    elevation: 3,
    borderSide: const BorderSide(
      color: Colors.transparent,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(40),
  ),
)
;
  }
}