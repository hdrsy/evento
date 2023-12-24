import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({super.key,
  required this.icon,
  required this.targetRout,
  required this.title

  });
final String title;
final String targetRout;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return 
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(8, 12,8, 0),
  child: InkWell(
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () async {
      
      Get.toNamed(targetRout);
    },
    child: Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color:customColors.secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color:customColors.primaryBackground,
            offset: const Offset(2, 2),
          )
        ],
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        border: Border.all(
          color:customColors.tertiary,
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
              color:customColors.secondaryText,
              size: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text(
                   title,
                  style:customTextStyle.bodySmall.override(
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
)
;
  }
}