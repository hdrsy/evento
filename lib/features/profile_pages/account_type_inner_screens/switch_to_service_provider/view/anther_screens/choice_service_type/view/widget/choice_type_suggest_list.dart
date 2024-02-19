import '../../../../../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../../../../../core/utils/theme/text_theme.dart';
import '../../controller/choice_type_controller.dart';
import '../../../../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

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
          ).tr(),
        ),
        Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                    choiceTypeController.isSearchActive.value
                        ? choiceTypeController.searchserviceCategoryList.length
                        : choiceTypeController.serviceCategoryList.length,
                    (index) => SuggestServiceCard(
                          title: choiceTypeController.isSearchActive.value
                              ? choiceTypeController
                                  .searchserviceCategoryList[index].title
                              : choiceTypeController
                                  .serviceCategoryList[index].title,
                          id: choiceTypeController.isSearchActive.value
                              ? choiceTypeController
                                  .searchserviceCategoryList[index].id
                              : choiceTypeController
                                  .serviceCategoryList[index].id,
                        )).divide(const SizedBox(
                  height: 10,
                ))
              ],
            ),
          ),
        )
      ].divide(const SizedBox(
        height: 5,
      )),
    );
  }
}

class SuggestServiceCard extends StatelessWidget {
  SuggestServiceCard({super.key, required this.title, required this.id});
  final String title;
  final int id;
  final ChoiceTypeController choiceTypeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoiceTypeController>(
      builder: (c) => Row(
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
              value: choiceTypeController.selectedCategories.contains(id),
              onChanged: (value) {
                choiceTypeController.changeSelectedService(id);
              },
              activeColor: customColors.primary,
              checkColor: customColors.info,
            ),
          ),
        ],
      ),
    );
  }
}
