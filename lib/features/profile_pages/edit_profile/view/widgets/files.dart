import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/auth/step3/view/widgets/build_day_month_year.dart';
import 'package:flutter/cupertino.dart';

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
  DateTime selectedDate =editProfileController.day;
    return SizedBox(
      width: double.infinity,
      child: Form(
        key: editProfileController.formstate,
        child: Column(
          children: [
            EditProfileField(
                suffixIcon: Icons.person_outline,
                controller: editProfileController.firstName,
                hintText: tr("Mohammad"),
                labelText: tr("First Name"),
                onChanged: (value) {
                  editProfileController.firstName.text = value;
                },
                validator: (value) {
                  return nameValidation(value);
                }),
            EditProfileField(
                suffixIcon: Icons.person_outline,
                controller: editProfileController.lastName,
                hintText: tr("Ahmad"),
                labelText: tr("Last Name"),
                onChanged: (value) {
                  editProfileController.lastName.text = value;
                },
                validator: (value) {
                  return nameValidation(value);
                }),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (_) => Container(
                          padding: padding(10, 0, 20, 0),
                          height: 300,
                          decoration: BoxDecoration(
                            color: customColors.secondaryBackground,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 200,
                                child: CupertinoTheme(
                                  data: CupertinoThemeData(
                                    textTheme: CupertinoTextThemeData(
                                      dateTimePickerTextStyle: TextStyle(
                                          color: customColors.secondaryText,
                                          fontSize: 20),
                                      pickerTextStyle: TextStyle(
                                          color: customColors.secondaryText),
                                    ),
                                  ),
                                  child: CupertinoDatePicker(
                                    initialDateTime:
                                        editProfileController.day,
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (val) {
                                      selectedDate = val;
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonWidget(
                                    // showLoadingIndicator: false,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    text: tr("Cancel"),
                                    options: ButtonOptions(
                                      width: 120,
                                      height: 45,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 20, 0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: customColors.secondaryBackground,
                                      textStyle:
                                          customTextStyle.titleSmall.override(
                                        fontFamily: 'BeerSerif',
                                        color: customColors.primaryText,
                                        fontSize: 14,
                                        useGoogleFonts: false,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: customColors.primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  ButtonWidget(
                                    onPressed: () {
                                      editProfileController.day = selectedDate;
                                      editProfileController.update();
                                      Get.back();
                                    },
                                    text: tr("Done"),
                                    options: ButtonOptions(
                                      width: 120,
                                      height: 45,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 20, 0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: customColors.primary,
                                      textStyle:
                                          customTextStyle.titleSmall.override(
                                        fontFamily: 'BeerSerif',
                                        color: customColors.info,
                                        fontSize: 14,
                                        useGoogleFonts: false,
                                      ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: customColors.primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ));
              },
              child: GetBuilder<EditProfileController>(builder: (context) {
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
                        DateFormatter.formatDate(editProfileController.day!),
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
                hintText: tr("Male"),
                labelText: tr("Gender"),
                onChanged: (value) {
                  editProfileController.gender.text = value;
                },
                validator: (value) {
                  if(value== "Male" || value =="Female"){
                  return null;
                  }
                    return "Plsease Type Your gender correctly";
                }),
          ].divide(SizedBox(
            height: scaleHeight(10),
          )),
        ),
      ),
    );
  }
}
