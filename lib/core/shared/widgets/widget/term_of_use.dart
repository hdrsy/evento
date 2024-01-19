import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class TermOfUse extends StatelessWidget {
  const TermOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return     Container(
            decoration: BoxDecoration(
                color: customColors.primaryBackground,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
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
                  normalDescription(introduction),
                  const SizedBox(
                    height: 10,
                  ),
                  middelTitle('2. Acceptance of Terms'),
                  normalDescription(acceptanceOfTerms),
                  const SizedBox(
                    height: 10,
                  ),
                  middelTitle('3. Account Registration and Security'),
                  normalDescription(accountRegistrationAndSecurity),
                  const SizedBox(
                    height: 10,
                  ),
                  middelTitle('4. Use of the App'),
                  normalDescription(useOfTheApp),
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
                  middelTitle('8. Request to Organize and Advertise Events via the App'),
                  normalDescription(cancellationAndRefund),
                  const SizedBox(
                    height: 10,
                  ),
                  middelTitle('9. Selection of Service Providers by Event Organizers'),
                  normalDescription(privacyAndDataProtection),
                  const SizedBox(
                    height: 10,
                  ),
                  middelTitle('10. Booking and Payment'),
                  normalDescription(amendmentsToTheTerms),
                  const SizedBox(
                    height: 10,
                  ),
                  middelTitle('11. Cancellation and Refund'),
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
                  normalDescription("""•	Changes to Terms: The app reserves the right to modify the terms of use at any time. Continued use of the app after any modifications constitutes agreement to these changes."""),
                  const SizedBox(
                    height: 10,
                  ),
                  middelTitle('14. Disclaimer and Limitations'),
                  normalDescription("""•	Disclaimer: The app provides its services "as is" without any warranties. The app is not responsible for any damages resulting from the use or inability to use the app."""),
                  const SizedBox(
                    height: 10,
                  ),
                  middelTitle('15. Contact and Support'),
                  normalDescription("""•	Support: For any inquiries or concerns regarding the terms of use, please contact the app's support team."""),
                  const SizedBox(
                    height: 10,
                  ),
                  normalDescription("""By using the "Evento" app, you acknowledge and agree to comply with these terms."""),
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
   String acceptanceOfTerms =
      'By using the "Evento" app, you agree to comply with these terms of use. If you do not agree to these terms, you must immediately stop using the app.';
   String accountRegistrationAndSecurity =
      """•	Account Creation: Accurate and complete information must be provided when creating your account. This includes your name, age, and mobile phone number.
•	Account Security: The user is responsible for maintaining the confidentiality of the password and any other registration information. The administration must be immediately informed of any unauthorized use of your account.""";
   String useOfTheApp ="""•	Legal Use: The app must be used in a legal and responsible manner. The use of the app for any illegal or prohibited purposes is forbidden.
•	Prohibited Content: It is prohibited to post or upload content that violates the rights of others, contains threats, obscenity, or breaches of public morals or ethics, or violates local and international laws.""";
     String intellectualPropertyRights ="""•	App Rights: All content on the app, including texts, graphics, and logos, is protected by intellectual property rights and belongs to the "Evento" app or to registered and accredited content and service providers on the app.""";
     String registrationAsServiceProvider ="""•	Event Announcement: The app announces events after studying and approving the advertisement request submitted by the advertiser.
•	Advertiser's Responsibility: The advertiser is responsible for all legal responsibilities related to the event, such as obtaining licenses and ensuring that the event does not violate the law, public morals, and ethics.""";
    String restaurantBookingPayment ="""Registration as a Service Provider
•	Service Provider Registration: Registration as a service provider requires compliance with all national laws and regulations governing consumer protection, commercial competition, and other relevant laws.
•	Service Provider Agreement: Registration as a service provider on the app requires a separate usage agreement with the app.""";
     String cancellationAndRefund ="""•	Event Approval: The app does not advertise any event before studying and approving the organization request.
•	Contractual Relations: Contractual relations arising from the event are valid only upon the app's approval of the event.""";
     String privacyAndDataProtection ="""•	Organizer's Choice: The event organizer's choice of a service provider for organizing an event is the organizer's responsibility.
•	Contractual Relationship: The contractual relationship for executing a service or event lies between the event organizer and the service provider.
•	App's Responsibility: The app is not responsible for executing events and does not guarantee the commitments of service providers. The app may only follow up with the service provider upon the organizer's request.""";
     
   String amendmentsToTheTerms ="""•	Booking Process: Tickets are booked through the app, and users must verify the booking details accurately before completing the process.
•	Inviting Attendees: Attendees can be invited to the event by selecting them from the friends list only.
•	Payment Methods: Ticket prices are paid using approved and secure electronic payment methods.
•	Ticket Resale: Resale of a ticket for a specific event is allowed only once, and the app charges a commission for the resale process.""";
    String disclaimerAndLimitations ="""•	Cancellation Policy: Cancellation operations are subject to the cancellation policy set by the event organizer and may be subject to fees or restrictions.
•	Refunds: In case of approval of cancellation, refunds are made according to the specified terms, after deducting any applicable fees.""";
   String contactAndSupportPartOne ="""•	Data Protection: The app is committed to protecting the privacy and personal data of users.
•	Data Use: Collected data is used to improve the experience on the app and provide personalized services.""";
   
Widget middelTitle(String title) {
  return SizedBox(
    width: screenWidth * .8,
    child: Text(
      title.tr(),
      style: customTextStyle.bodyMedium
          .copyWith(color: customColors.secondaryText, fontWeight: FontWeight.bold),
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