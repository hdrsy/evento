import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

Row numberOfShowing() {
  
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
         Icon(
          Icons.headphones_sharp,
          color: customColors.primaryText,
          size: 15,
        ),
        Align(
          alignment: const AlignmentDirectional(-1.00, 1.00),
          child: Text(
            "6.6k",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.primaryText,
              fontSize: 14,
              useGoogleFonts: true,
            ),
          ),
        ),
      ],
    );
  }

