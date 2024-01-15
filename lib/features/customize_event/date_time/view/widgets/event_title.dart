import '../../../../../core/shared/functions/validation/name_validation.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/date_time_controller.dart';
import 'text_field_contact_information.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class EventTitle extends StatelessWidget {
   EventTitle({super.key});
 final DateTimeController dateTimeController = Get.find();
 
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
                "Event Title",
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
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: customColors.primaryBackground,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 00, 10, 0),
            child: Form(
              // key: dateTimeController.formstate,
              child: TextFieldContactInformation(
                      labelKey:tr( "Event title"),
                      hintTextKey:tr( 'Label here...'),
                      controller: dateTimeController.eventTitle,
                      onChanged: (value) {
                        dateTimeController.eventTitle.text = value;
                      },
                      validator: (value) {
                        return nameValidation(value);
                      }),
                 
            ),
          ),
        ),
      ],
    );
  }
}