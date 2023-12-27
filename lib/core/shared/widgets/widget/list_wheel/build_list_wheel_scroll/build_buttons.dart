import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

Padding buildButtons(
    {required BuildContext context, Function()? onPressedSubmit}) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonWidget(
          showLoadingIndicator: false,
          onPressed: () async {
            Navigator.pop(context);
          },
          text: 'Cancel',
          options: ButtonOptions(
            height: 30,
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.secondaryBackground,
            textStyle: customTextStyle.titleSmall.override(
                  fontFamily: 'Readex Pro',
                  color: customColors.primary,
                ),
            elevation: 3,
            borderSide: BorderSide(
              color: customColors.primaryBackground,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        ButtonWidget(
          showLoadingIndicator: false,
          onPressed: onPressedSubmit,
          text: 'Submit',
          options: ButtonOptions(
            height: 30,
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.primary,
            textStyle: customTextStyle.titleSmall.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                ),
            elevation: 3,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    ),
  );
}
