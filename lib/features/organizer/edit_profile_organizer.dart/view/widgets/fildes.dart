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
                controller: editProfileController.sepecialities,
                hintText: tr("Decoration"),
                labelText: tr("Sepecialities"),
                onChanged: (value) {
                  editProfileController.sepecialities.text = value;
                },
                validator: (value) {
                  return null;
                }),
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
        options: states,
        selectedValues: _selectedValues,
        onSelectionChanged: _handleSelectionChange);
  }
}
