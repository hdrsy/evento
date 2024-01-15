import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../organizer/organizer_conditions/view/organizer_conditions_widget.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class BecomOrganizer extends StatelessWidget {
  const BecomOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
showButtonSheet(context: context, widget: const OrganizerConditionsWidget(), height: 700);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(tr("Become an Organizer"),style: customTextStyle.bodyMedium.copyWith(
    fontSize: screenSize == ScreenSize.small
                        ? 14
                        : (screenSize == ScreenSize.medium ? 16 : 18),
                        color: customColors.primary,
                        fontWeight: FontWeight.w800
          ),),
          Icon(Icons.arrow_forward,size: screenSize == ScreenSize.small
                        ? 16
                        : (screenSize == ScreenSize.medium ? 18 : 18),
                        color: customColors.primary,
                        )
        ],
      ),
    );
  }
}