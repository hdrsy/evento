import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';

class RightTextWidget extends StatelessWidget {
  const RightTextWidget({super.key,required this. value});
final String value;
  @override
  Widget build(BuildContext context) {
    return  Text(
                   value,
                  style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.primary,
                        fontSize: 14,
                        useGoogleFonts: true,
                      ),
                );
  }
}