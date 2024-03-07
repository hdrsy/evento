import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class AccountText extends StatelessWidget {
  const AccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(-1.00, -1.00),
      child: Text(
        tr("Account"),
        style: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          color: customColors.primaryText,
          fontWeight: FontWeight.normal,
          useGoogleFonts: true,
        ),
      ),
    );
  }
}
