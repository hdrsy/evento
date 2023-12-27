import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/date_time/controller/date_time_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextStepButton extends StatelessWidget {
   NextStepButton({super.key});
final DateTimeController dateTimeController=Get.find();
  
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
  onPressed: () async {
   dateTimeController.onPressedNext();
  },
  text: "Next Step",
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