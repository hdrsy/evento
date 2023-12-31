import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/date_time/view/widgets/people_date_time_bottom_sheet.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class SelectPeopleDateTime extends StatelessWidget {
  const SelectPeopleDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
       splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
      onTap: (){
        showButtonSheet(context: context, widget: PeopleDateTimeBottomSheet(), height: screenHeight*0.6);
      },
      child: Container(
      width: 360,
      height: 40,
      decoration: BoxDecoration(
        color: customColors.primaryBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: customColors.tertiary,
        ),
      ),
      child:
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      Container(
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              child: Icon(
                Icons.people_outlined,
                color: customColors.secondaryText,
                size: 18,
              ),
            ),
            Text(
               "People",
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: true,
                  ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 100,
        child: VerticalDivider(
          thickness: 2,
          color: customColors.secondaryBackground,
        ),
      ),
      Container(
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              child: Icon(
                Icons.date_range_outlined,
                color: customColors.secondaryText,
                size: 18,
              ),
            ),
            Text(
               "Date",
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: true,
                  ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 100,
        child: VerticalDivider(
          thickness: 2,
          color: customColors.secondaryBackground,
        ),
      ),
      Container(
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              child: Icon(
                Icons.access_time,
                color: customColors.secondaryText,
                size: 18,
              ),
            ),
            Text(
              "Time",
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: true,
                  ),
            ),
          ],
        ),
      ),
      ],
    )),
    )
;
  }
}