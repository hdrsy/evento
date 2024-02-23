import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class TermOfUse extends StatelessWidget {
  const TermOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: customColors.primaryBackground,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        width: double.infinity,
        height: screenHeight * .8,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                '"Evento" App Usage Policy'.tr(),
                style: customTextStyle.bodyLarge.copyWith(
                  fontFamily: 'Inter',
                  color: customColors.primaryText,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Introduction'),
              normalDescription('Introduction_body'),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Acceptance_of_Terms'),
              normalDescription('Acceptance_of_Terms_body'),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Account_Registration_and_Security'),
              normalDescription('Account_Registration_and_Security_body'),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Use_of_the_App'),
              normalDescription('Use_of_the_App_body'),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Intellectual_Property_Rights'),
              normalDescription("Intellectual_Property_Rights_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Event_Advertising'),
              normalDescription("Event_Advertising_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Registration_as_a_Service_Provider'),
              normalDescription("Registration_as_a_Service_Provider_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Organizing_and_Advertising_Events_via_the_App'),
              normalDescription(
                  "Organizing_and_Advertising_Events_via_the_App_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Selecting_Service_Providers_by_Event_Organizers'),
              normalDescription(
                  "Selecting_Service_Providers_by_Event_Organizers_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Booking_and_Payment'),
              normalDescription("Booking_and_Payment_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Cancellation_and_Refund'),
              normalDescription("Cancellation_and_Refund_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Privacy_and_Data_Protection'),
              normalDescription("Privacy_and_Data_Protection_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Amendments_to_the_Terms'),
              normalDescription("Amendments_to_the_Terms_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Disclaimer_and_Limitations'),
              normalDescription("Disclaimer_and_Limitations_body"),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Contact_and_Support'),
              normalDescription("Contact_and_Support_body"),
              const SizedBox(
                height: 10,
              ),
              normalDescription("Acceptance_of_Terms_final")
            ],
          ),
        )));
  }
}

Widget middelTitle(String title) {
  return SizedBox(
    width: screenWidth * .8,
    child: Text(
      title.tr(),
      style: customTextStyle.bodyMedium.copyWith(
          color: customColors.secondaryText, fontWeight: FontWeight.bold),
      overflow: TextOverflow.fade,
    ),
  );
}

Widget normalDescription(String description) {
  return SizedBox(
    width: screenWidth * .9,
    child: Text(
      description.tr(),
      style: customTextStyle.bodySmall.copyWith(
          color: customColors.secondaryText, fontWeight: FontWeight.w600),
      overflow: TextOverflow.fade,
    ),
  );
}
