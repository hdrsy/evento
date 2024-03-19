// import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsCard extends StatelessWidget {
  OptionsCard(
      {super.key,
      required this.icon,
      required this.targetRout,
      required this.title,
      this.bottomSheetHeight});
  final String title;
  final dynamic targetRout;
  final IconData icon;
  final double? bottomSheetHeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
      child: GestureDetector(
        onTap: () async {
          if (targetRout is String && targetRout == '/') {
            Get.offAllNamed('/');
            prefService.remove('token');
            prefService.remove('userInfo');
            prefService.remove('isCompleteProfile');
          } else {
            targetRout is String
                ? Get.toNamed(targetRout)
                : showButtonSheet(
                    context: context,
                    widget: targetRout,
                    height: bottomSheetHeight ?? screenHeight * 0.2);
          }
        },
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: customColors.primaryBackground,
                offset: const Offset(2, 2),
              )
            ],
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: customColors.tertiary,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 10, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                  color: customColors.secondaryText,
                  size: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      title,
                      style: customTextStyle.bodySmall.override(
                        fontFamily: 'Nunito',
                        color: customColors.primaryText,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts: true,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: customColors.secondaryText,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
