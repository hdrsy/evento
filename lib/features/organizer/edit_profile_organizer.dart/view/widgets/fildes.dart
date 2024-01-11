import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/functions/validation/name_validation.dart';
import 'package:evento/core/shared/functions/validation/phone_validation.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/text_fields/edit_profile_field.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/controller/edit_profile_controller.dart';
import 'package:evento/features/profile_pages/edit_profile/controller/edit_profile_controller.dart';
import 'package:evento/features/profile_pages/edit_profile/view/widgets/selected_list_edit_profile.dart';
import 'package:evento/features/service_provider/edit_profile_service_provider.dart/controller/edit_profile_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fields extends StatelessWidget {
  Fields({super.key});
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
                hintText: "Mohammad",
                labelText: "First Name",
                onChanged: (value) {
                  editProfileController.firstName.text = value;
                },
                validator: (value) {
                  return nameValidation(value);
                }),
            EditProfileField(
                suffixIcon: Icons.person_outline,
                controller: editProfileController.bio,
                hintText: "Crweted Events",
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
                hintText: "Decoration",
                labelText: "Sepecialities",
                onChanged: (value) {
                  editProfileController.sepecialities.text = value;
                },
                validator: (value) {
                  return null;
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

            ].divide(SizedBox(
            height: scaleHeight(10),
          )),
        ),
      ),
    );
  }
}
