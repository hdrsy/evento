import '../../../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../../../core/utils/theme/text_theme.dart';
import '../../controller/choice_organizer_category_controller.dart';
import '../../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class ChoiceOrganizerCategoryList extends StatelessWidget {
  ChoiceOrganizerCategoryList({super.key});
  final ChoiceOrganizerCategoryController choiceOrganizerCategoryController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                  choiceOrganizerCategoryController.isSearchActive.value
                      ? choiceOrganizerCategoryController
                          .searchchoiceServiceList.length
                      : choiceOrganizerCategoryController
                          .choiceServiceList.length,
                  (index) => OrganizerCategoryCard(
                        choiceOrganizerCategoryTypeModel:
                            choiceOrganizerCategoryController
                                    .isSearchActive.value
                                ? choiceOrganizerCategoryController
                                    .searchchoiceServiceList[index]
                                : choiceOrganizerCategoryController
                                    .choiceServiceList[index],
                      )).divide(const SizedBox(
                height: 10,
              )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Other",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primaryText,
                      fontSize: 16,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
                ].divide(const SizedBox(width: 5)),
              ),
              const SizedBox(
                height: 10,
              ),
              OtherTextField()
            ],
          )
        ].divide(const SizedBox(
          height: 5,
        )),
      ),
    );
  }
}

class OrganizerCategoryCard extends StatelessWidget {
  OrganizerCategoryCard(
      {super.key, required this.choiceOrganizerCategoryTypeModel});
  final ChoiceOrganizerCategoryTypeModel choiceOrganizerCategoryTypeModel;
  final ChoiceOrganizerCategoryController choiceOrganizerCategoryController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoiceOrganizerCategoryController>(
      builder: (c) => InkWell(
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
                  choiceOrganizerCategoryTypeModel.name,
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
                value: choiceOrganizerCategoryController.selectedCategories
                    .contains(choiceOrganizerCategoryTypeModel.categoryId),
                onChanged: (value) {
                  choiceOrganizerCategoryController.changeSelectedService(
                      choiceOrganizerCategoryTypeModel.categoryId);
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

class OtherTextField extends StatelessWidget {
  OtherTextField({super.key});
  final ChoiceOrganizerCategoryController choiceOrganizerCategoryController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: choiceOrganizerCategoryController.sericeSelected,
      obscureText: false,
      decoration: InputDecoration(
        labelStyle: customTextStyle.labelMedium,
        hintText: tr("Other specialties"),
        hintStyle: customTextStyle.labelMedium.override(
          fontFamily: 'Nunito',
          color: customColors.secondaryText,
          useGoogleFonts: true,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: customColors.primaryBackground,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: customColors.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: customColors.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: customColors.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: customTextStyle.bodyMedium,
    );
  }
}
