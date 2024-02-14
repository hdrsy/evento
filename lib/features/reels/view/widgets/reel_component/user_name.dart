import 'package:evento/core/colors/app_colors.dart';

import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';

Column userName(String userName) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        userName,
        style: customTextStyle.bodyLarge.override(
            fontFamily: 'Nunito',
            color: AppColors.darkPrimaryText,
            useGoogleFonts: true,
            fontSize: 16),
      ),
    ],
  );
}
