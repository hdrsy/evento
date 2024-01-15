import '../../../../../core/shared/functions/validation/name_validation.dart';
import '../../../../../core/shared/functions/validation/phone_validation.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/date_time_controller.dart';
import 'text_field_contact_information.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class ContactInformationForm extends StatelessWidget {
  // Assuming controllers, focusNodes, and validators are defined elsewhere
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final DateTimeController dateTimeController = Get.find();
  ContactInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Contact Information",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
            ],
          ),
        ),
        Container(
          width: 360,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: customColors.primaryBackground,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 00, 10, 0),
            child: Form(
              key: dateTimeController.formstate,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFieldContactInformation(
                      labelKey:tr( "First name"),
                      hintTextKey:tr( 'Label here...'),
                      controller: dateTimeController.firstName,
                      onChanged: (value) {
                        dateTimeController.firstName.text = value;
                      },
                      validator: (value) {
                        return nameValidation(value);
                      }),
                  Divider(
                    thickness: 1,
                    color: customColors.secondaryBackground,
                  ),
                  TextFieldContactInformation(
                      labelKey:tr( " Last name"),
                      hintTextKey:tr( 'Label here...'),
                      controller: dateTimeController.lastName,
                      onChanged: (value) {
                        dateTimeController.lastName.text = value;
                      },
                      validator: (value) {
                        return nameValidation(value);
                      }),
                  Divider(
                    thickness: 1,
                    color: customColors.secondaryBackground,
                  ),
                  TextFieldContactInformation(
                      labelKey:tr( "Phone Number"),
                      hintTextKey:tr( 'Label here...'),
                      controller: dateTimeController.phoneNumber,
                      onChanged: (value) {
                        dateTimeController.phoneNumber.text = value;
                      },
                      validator: (value) {
                        return nameValidation(value);
                      }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
