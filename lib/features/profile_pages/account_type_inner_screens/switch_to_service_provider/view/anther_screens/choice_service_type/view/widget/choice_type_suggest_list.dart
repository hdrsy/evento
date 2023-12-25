
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/switch_to_service_provider/view/anther_screens/choice_service_type/controller/choice_type_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceTypeSuggestList extends StatelessWidget {
  ChoiceTypeSuggestList({super.key});
  final ChoiceTypeController choiceTypeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1, -1),
          child: Text(
            "Suggested ",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              useGoogleFonts: true,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        
        ...List.generate(
            choiceTypeController.choiceServiceList.length,
            (index) => SuggestServiceCard(
                  title: choiceTypeController.choiceServiceList[index].name,
                )).divide(const SizedBox(height: 10,))
            ],
          ),
        )
      ].divide(const SizedBox(height: 5,)),
    );
  }
}

class SuggestServiceCard extends StatelessWidget {
  SuggestServiceCard({super.key, required this.title});
  final String title;
  final ChoiceTypeController choiceTypeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoiceTypeController>(
      builder:(c)=> InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          // context.pushNamed('Account-privacy');
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primaryText,
                    fontSize: 16,
                    useGoogleFonts: true,
                  ),
                ),
              ].divide(const SizedBox(width: 5)),
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
                unselectedWidgetColor: customColors.secondaryText,
              ),
              child: Checkbox(
                value: choiceTypeController.sericeSelected == title,
                onChanged: (value) {
                  choiceTypeController.changeSelectedService(title);
                  
                },
                activeColor: customColors.primary,
                checkColor: customColors.info,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
