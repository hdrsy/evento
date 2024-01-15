import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class CustomizeEventButton extends StatelessWidget {
  const CustomizeEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
  onPressed: () async {
    Get.toNamed('/dateTimeScreen');
    },
  text:tr(  "Customize Event"),
  icon: Icon(
    Icons.settings,
    color: customColors.info,
    size: 15,
  ),
  options: ButtonOptions(
    height: 40,
    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    color: customColors.primary,
    textStyle: customTextStyle.titleSmall.copyWith(
      color: customColors.info
    ),
    elevation: 3,
    borderSide: const BorderSide(
      color: Colors.transparent,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(30),
  ),
)
;
  }
}