import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/edit_profile/view/widgets/change_pass_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return 
Align(
  alignment: const AlignmentDirectional(0.00, 0.05),
  child: Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    child: ButtonWidget(
      onPressed: () async {
        await showButtonSheet(context: context, widget: const ChangpassWidget(), height: 300);
              },
      text: "Change Password",
      options: ButtonOptions(
        height: 44,
        padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.secondaryText,
        textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              useGoogleFonts: true,
            ),
        elevation: 3,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
)
;
  }
}