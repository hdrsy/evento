import '../../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../model/event_detailes_model.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
Widget buildEventTimelineButton(BuildContext context,EventDetailsModel eventDetailsModel){
  return 
ButtonWidget(
  onPressed: () async {
    Get.toNamed('/eventTimeLine',arguments: eventDetailsModel);
  },
  text:tr(  "Event Timeline"),
  options: ButtonOptions(
    width: 250,
    height: 40,
    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    color: customColors.primary,
    textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Open Sans',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
    elevation: 3,
    borderSide:const BorderSide(
      color: Colors.transparent,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(30),
  ),
)
;
}