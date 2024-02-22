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
              middelTitle('1. Introduction'),
              normalDescription('introduction_body'),
              const SizedBox(
                height: 10,
              ),
              middelTitle('2. Acceptance of Terms'),
              normalDescription('Acceptance of Terms body'),
              const SizedBox(
                height: 10,
              ),
              middelTitle('3. Account Registration and Security'),
              normalDescription('Account Registration and Security body'),
              const SizedBox(
                height: 10,
              ),
              middelTitle('4. Use of the App'),
              normalDescription('Use of the App body'),
              const SizedBox(
                height: 10,
              ),
              middelTitle('5. Intellectual Property Rights'),
              normalDescription(intellectualPropertyRights),
              const SizedBox(
                height: 10,
              ),
              middelTitle('6. Event Advertising'),
              normalDescription(registrationAsServiceProvider),
              const SizedBox(
                height: 10,
              ),
              middelTitle('7. Registration as a Service Provider'),
              normalDescription(restaurantBookingPayment),
              const SizedBox(
                height: 10,
              ),
              middelTitle(
                  '8. Request to Organize and Advertise Events via the App'),
              normalDescription(cancellationAndRefund),
              const SizedBox(
                height: 10,
              ),
              middelTitle(
                  '9. Selection of Service Providers by Event Organizers'),
              normalDescription(privacyAndDataProtection),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Booking and Payment'),
              normalDescription(amendmentsToTheTerms),
              const SizedBox(
                height: 10,
              ),
              middelTitle('Cancellation and Refund'),
              normalDescription(disclaimerAndLimitations),
              const SizedBox(
                height: 10,
              ),
              middelTitle('12. Privacy and Data Protection'),
              normalDescription(contactAndSupportPartOne),
              const SizedBox(
                height: 10,
              ),
              middelTitle('13. Amendments to the Terms'),
              normalDescription(
                  """•	Changes to Terms: The app reserves the right to modify the terms of use at any time. Continued use of the app after any modifications constitutes agreement to these changes."""),
              const SizedBox(
                height: 10,
              ),
              middelTitle('14. Disclaimer and Limitations'),
              normalDescription(
                  """•	Disclaimer: The app provides its services "as is" without any warranties. The app is not responsible for any damages resulting from the use or inability to use the app."""),
              const SizedBox(
                height: 10,
              ),
              middelTitle('15. Contact and Support'),
              normalDescription(
                  """•	Support: For any inquiries or concerns regarding the terms of use, please contact the app's support team."""),
              const SizedBox(
                height: 10,
              ),
              normalDescription(
                  """By using the "Evento" app, you acknowledge and agree to comply with these terms."""),
            ],
          ),
        )));
  }
}

String youCanSelectPhoto =
    "You can select photo from one of this emoji or add your own photo as profile picture";
String longRestaurantDEscription =
    "You can select photo from one of this emoji or add your own photo as profile pictureYou can select photo from one of this emoji or add your own photo as profile pictureYou can select photo from one of this emoji or add your own photo as profile pictureYou can select photo from one of this emoji or add your own photo as profile pictureYou can select photo from one of this emoji or add your own photo as profile pictureYou can select photo from one of this emoji or add your own photo as profile picture";
String changePasswordTitle =
    'Your passowrd should be at least 6 characters and should include a combination of numbers, letters and special characters (!\$@%)';
String unfriendMessage =
    'Please remember that unfriending someone will remove them from your friend list, and you won\'t be able to see their private posts or interact as friends on this platform.';
String introduction =
    '"Evento" is a digital platform specialized in marketing and booking community events. Please read these terms of use carefully before using the app to ensure your understanding and agreement with these terms.';
String accountRegistrationAndSecurity = "Account Creation body";
String acceptanceOfTerms =
    'By using the "Evento" app, you agree to comply with these terms of use. If you do not agree to these terms, you must immediately stop using the app.';
String useOfTheApp = "Use of the App body";
String intellectualPropertyRights = "intellectualPropertyRights";
String registrationAsServiceProvider = "registrationAsServiceProvider";
String restaurantBookingPayment = "restaurantBookingPayment";
String cancellationAndRefund = "cancellationAndRefund";
String privacyAndDataProtection = "privacyAndDataProtection";

String amendmentsToTheTerms = "amendmentsToTheTermsbody";
String disclaimerAndLimitations =
    """•	Cancellation Policy: Cancellation operations are subject to the cancellation policy set by the event organizer and may be subject to fees or restrictions.
•	Refunds: In case of approval of cancellation, refunds are made according to the specified terms, after deducting any applicable fees.""";
String contactAndSupportPartOne =
    """•	Data Protection: The app is committed to protecting the privacy and personal data of users.
•	Data Use: Collected data is used to improve the experience on the app and provide personalized services.""";

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
