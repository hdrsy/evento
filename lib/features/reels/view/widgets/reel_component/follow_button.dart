
  import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

ButtonWidget followButton() {
    return ButtonWidget(
      onPressed: () {
       },
      text: "Follow",
      options: ButtonOptions(
        width: 85,
        height: 31,
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.primaryText,
        textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          color: customColors.info,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          useGoogleFonts: true,
        ),
        borderSide: BorderSide(
          color: customColors.primaryBackground,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }