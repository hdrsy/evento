import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/functions/validation/name_validation.dart';
import '../../../../../core/shared/functions/validation/phone_validation.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../../core/shared/widgets/text_fields/edit_profile_field.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../controller/edit_profile_controller.dart';
import 'selected_list_edit_profile.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class Fields extends StatelessWidget {
  Fields({super.key});
  final EditProfileController editProfileController = Get.find();

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
                hintText:tr( "Mohammad"),
                labelText:tr( "First Name"),
                onChanged: (value) {
                  editProfileController.firstName.text = value;
                },
                validator: (value) {
                  return nameValidation(value);
                }),
            EditProfileField(
                suffixIcon: Icons.person_outline,
                controller: editProfileController.lastName,
                hintText:tr( "Ahmad"),
                labelText: tr("Last Name"),
                onChanged: (value) {
                  editProfileController.lastName.text = value;
                },
                validator: (value) {
                  return nameValidation(value);
                }),
            EditProfileField(
                suffixIcon: Icons.calendar_month,
                controller: editProfileController.date,
                hintText:tr( "19/7/1999"),
                labelText:tr( "Date of Brith"),
                onChanged: (value) {
                  editProfileController.date.text = value;
                },
                validator: (value) {
                  return null;
                }),
            EditProfileField(
                suffixIcon: Icons.phone_outlined,
                controller: editProfileController.phone,
                hintText:tr( "+963 900000000"),
                labelText:tr( "Phone Number"),
                onChanged: (value) {
                  editProfileController.phone.text = value;
                },
                validator: (value) {
                  return phoneValidation(value);
                }),
        
            InkWell(
              onTap: () async {
                await showButtonSheet(
                    context: context,
                    widget: SelectStateEditProfile(),
                    height: 300);
              },
              child: GetBuilder<EditProfileController>(builder: (ccontext) {
                return Container(
                  width: double.infinity,
                  height: scaleHeight(50),
                  padding: padding(0, 10, 0, 10),
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: customColors.primaryBackground,
                        width: 2,
                      ),
                      color: customColors.secondaryBackground),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        editProfileController.selectedState,
                        style: customTextStyle.bodyMedium,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: customColors.secondaryText,
                        size: 15,
                      )
                    ],
                  ),
                );
              }),
            ),

            EditProfileField(
                suffixIcon: Icons.people_alt_outlined,
                controller: editProfileController.gender,
                hintText:tr( "Male"),
                labelText:tr( "Gender"),
                onChanged: (value) {
                  editProfileController.gender.text = value;
                },
                validator: (value) {
                  return null;
                }),
          ].divide(SizedBox(
            height: scaleHeight(10),
          )),
        ),
      ),
    );
  }
}
