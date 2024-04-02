import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class LeftTextWidget extends StatelessWidget {
  const LeftTextWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      tr(title),
      style: customTextStyle.labelMedium.override(
        fontFamily: 'Nunito',
        color: customColors.primaryText,
        fontSize: 14,
        useGoogleFonts: false,
      ),
    );
  }
}
