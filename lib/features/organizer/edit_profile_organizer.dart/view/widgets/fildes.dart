import 'package:evento/core/const/states.dart';
import 'package:evento/core/utils/helper/multy_selected_dropdown.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/functions/validation/name_validation.dart';
import '../../../../../core/shared/widgets/text_fields/edit_profile_field.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class FieldsOrganizer extends StatelessWidget {
  FieldsOrganizer({super.key});
  final EditProfileOrganizerController editProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Form(
        key: editProfileController.formstate,
        child: Column(
          children: [
            EditProfileField(
                suffixIcon: Icons.person_outline,
                controller: editProfileController.firstName,
                hintText: tr("Spark"),
                labelText: tr("Organization/Name"),
                onChanged: (value) {
                  editProfileController.firstName.text = value;
                },
                validator: (value) {
                  return nameValidation(value);
                }),
            EditProfileField(
                suffixIcon: Icons.person_outline,
                controller: editProfileController.bio,
                hintText: tr(
                    """Event organizer specialist in decoration ,lighting and flowers .Wdding, Birthday ,anniversary......"""),
                labelText: "Bio",
                onChanged: (value) {
                  editProfileController.bio.text = value;
                },
                validator: (value) {
                  return null;
                }),
            EditProfileField(
                suffixIcon: Icons.calendar_month,
                controller: editProfileController.otherCatogery,
                hintText: tr("Other category"),
                labelText: tr("Sepecialities"),
                onChanged: (value) {
                  editProfileController.otherCatogery.text = value;
                },
                validator: (value) {
                  return null;
                }),
            SelectCategory(),
            SelectStates()
          ].divide(SizedBox(
            height: scaleHeight(10),
          )),
        ),
      ),
    );
  }
}

class SelectStates extends StatefulWidget {
  const SelectStates({
    super.key,
  });

  @override
  State<SelectStates> createState() => _SelectStates();
}

class _SelectStates extends State<SelectStates> {
  @override
  initState() {
    final EditProfileOrganizerController editProfileOrganizerController =
        Get.find();
    _selectedValues
        .addAll(editProfileOrganizerController.profileModel.state.split(', '));
    print("the states:${_selectedValues}");
    super.initState();
  }

  List<String> _selectedValues = [];

  void _handleSelectionChange(List<String> newSelections) {
    setState(() {
      _selectedValues = newSelections;
    });
    Get.find<EditProfileOrganizerController>().selectedState =
        newSelections.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
        title: "Covering Areas",
        options: states,
        selectedValues: _selectedValues,
        onSelectionChanged: _handleSelectionChange);
  }
}

class SelectCategory extends StatefulWidget {
  const SelectCategory({
    super.key,
  });

  @override
  State<SelectCategory> createState() => _SelectCategory();
}

class _SelectCategory extends State<SelectCategory> {
  @override
  initState() {
    final EditProfileOrganizerController editProfileOrganizerController =
        Get.find();

    _selectedValues.addAll(editProfileOrganizerController.choiceServiceList
        .where((element) => editProfileOrganizerController.selectedCategories
            .contains(element.categoryId))
        .map((e) => e.name));

    super.initState();
  }

  List<String> _selectedValues = [];

  void _handleSelectionChange(List<String> newSelections) {
    setState(() {
      _selectedValues = newSelections;
    });

    final EditProfileOrganizerController editProfileOrganizerController =
        Get.find();

    // Clear existing categories if you're replacing them, or skip this if you're appending
    editProfileOrganizerController.selectedCategories.clear();

    // Find matching category IDs and add them to the controller's list
    newSelections.forEach((selectedName) {
      // Find the first match in choiceServiceList for the selectedName
      var matchingCategory = editProfileOrganizerController.choiceServiceList
          .firstWhereOrNull((element) => element.name == selectedName);

      // If a match was found, add its categoryId to selectedCategories
      if (matchingCategory != null) {
        editProfileOrganizerController.selectedCategories
            .add(matchingCategory.categoryId);
      }
    });

    print(newSelections);
    print(
        "The selected values: ${editProfileOrganizerController.selectedCategories}");
  }

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
        options: Get.find<EditProfileOrganizerController>()
            .choiceServiceList
            .map((e) => e.name)
            .toList(),
        selectedValues: _selectedValues,
        title: "Event category",
        onSelectionChanged: _handleSelectionChange);
  }
}
