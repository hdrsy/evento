import 'package:evento/core/responsive/size_config.dart';

import '../../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../model/event_detailes_model.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildEventTimelineButton(
    BuildContext context, EventDetailsModel eventDetailsModel) {
  return ButtonWidget(
    onPressed: () async {
      Get.toNamed('/eventTimeLine', arguments: eventDetailsModel);
    },
    icon: Icon(
      Icons.view_timeline_outlined,
      size: SizeConfig.safeBlockHorizontal * 3.3,
    ),
    text: tr("Timeline"),
    options: ButtonOptions(
      width: SizeConfig.safeBlockHorizontal * 30,
      height: SizeConfig.safeBlockHorizontal * 6,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      color: customColors.primaryBackground,
      textStyle: customTextStyle.titleSmall.override(
        fontFamily: 'Open Sans',
        color: customColors.primaryText,
        fontSize: SizeConfig.safeBlockHorizontal * 3.3,
        fontWeight: FontWeight.w500,
      ),
      elevation: 3,
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
