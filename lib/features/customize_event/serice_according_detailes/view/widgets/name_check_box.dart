import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class NameCheckBox extends StatelessWidget {
  const NameCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return 
Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
           "Abernathy Reynolds",
          style: customTextStyle.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
          child: Text(
             "Description ",
            maxLines: 20,
            style: customTextStyle.labelMedium,
          ),
        ),
      ],
    ),
    InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // context.pushNamed('Services');
      },
      child: Container(
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              " Add To Event",
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),
            ),
            Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                unselectedWidgetColor:
                    customColors.secondaryText,
              ),
              child: Checkbox(
                value:  false,
                onChanged: (newValue) async {
                 },
                activeColor: customColors.success,
                checkColor: customColors.info,
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)
;
  }
}