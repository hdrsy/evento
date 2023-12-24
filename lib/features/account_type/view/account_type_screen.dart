// Importing necessary packages and widgets.
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/account_type/view/widgets/account_type_card.dart';
import 'package:evento/features/account_type_inner_screens/evento_verification_bottom_sheet/view/evento_verification_conditions_bottom_sheet.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Defining the AccountTypeScreen as a StatelessWidget.
class AccountTypeScreen extends StatelessWidget {
  // Constructor with optional key parameter.
  const AccountTypeScreen({super.key});

  @override
  // Building the widget.
  Widget build(BuildContext context) {
    return Scaffold(
      // Setting the background color of the screen.
      backgroundColor: customColors.secondaryBackground,

      // Configuring the app bar.
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(
          "Account Type",
          style: customTextStyle.bodyMedium
              .copyWith(color: customColors.primary, fontSize: 20),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back(); // Navigating back on tap.
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),

      // Setting the body of the Scaffold.
      body: SingleChildScrollView(
        // Applying padding around the content.
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Adding a search text field.
            searchTextField(onChanged: (value) {}),
            
            // Aligning the text to the start.
            Align(
              alignment: const AlignmentDirectional(-1, -1),
              child: Text(
                "Your Account",
                style: customTextStyle.bodyMedium.override(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: customColors.secondaryText,
                  fontFamily: 'Nunito',
                  useGoogleFonts: true,
                ),
              ),
            ),
            
            // Adding various account type cards with icons and routes.
            const AccountTypeCard(
              icon: Icons.privacy_tip_outlined,
              route: 'AccountPrivacyScreen',
              title: "Account privacy",
            ),
            const AccountTypeCard(
              icon: Icons.phone_outlined,
              route: 'SwithcToServiceProviderScreen',
              title: "Switch to service provider",
            ),
            const AccountTypeCard(
              icon: Icons.people_outlined,
              route: EventVerificationCondidtionsBottomSheet(),
              title: "Sign up for Evento Verified",
            ),
            const AccountTypeCard(
              icon: Icons.people_outlined,
              route: 'AccountOrganizerScreen',
              title: "Become an Organizer",
            ),
          ].divide(const SizedBox(height: 16,)), // Dividing the cards with spacing.
        ),
      ),
    );
  }
}
