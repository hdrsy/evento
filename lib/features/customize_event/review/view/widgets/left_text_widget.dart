import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';

class LeftTextWidget extends StatelessWidget {
  const LeftTextWidget({super.key,required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    return  Text(
                          title,
                          style:  customTextStyle.labelMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.primaryText,
                        fontSize: 14,
                        useGoogleFonts: false,
                      ),
                        );
  }
}