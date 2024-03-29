// Importing necessary packages and widgets.
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/account_type/controller/account_type_controller.dart';
import 'package:evento/features/profile_pages/account_type/view/widgets/account_type_card.dart';
import 'package:evento/features/profile_pages/account_type/view/widgets/delete_account_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// Defining the AccountTypeScreen as a StatelessWidget.
class AccountTypeScreen extends StatelessWidget {
  // Constructor with optional key parameter.
  AccountTypeScreen({super.key});
  final AccountTypeController accountTypeController = Get.find();
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
        ).tr(),
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
      body: Obx(
        () => SingleChildScrollView(
          // Applying padding around the content.
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Adding a search text field.
              // searchTextField(onChanged: (value) {}),

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
                ).tr(),
              ),
              // Adding various account type cards with icons and routes.
              AccountTypeCard(
                  icon: Icons.miscellaneous_services,
                  route: 'SwithcToServiceProviderScreen',
                  title: tr("Switch to service provider"),
                  isPrivateAccount:
                      accountTypeController.isAccountPrivate.value),
              // const AccountTypeCard(
              //   icon: Icons.people_outlined,
              //   route: EventVerificationCondidtionsBottomSheet(),
              //   title: "Sign up for Evento Verified",
              // ),
              AccountTypeCard(
                  icon: Icons.people_outlined,
                  route: 'AccountOrganizerScreen',
                  title: tr("Become an Organizer"),
                  isPrivateAccount:
                      accountTypeController.isAccountPrivate.value),
              Divider(
                thickness: 0.5,
                color: customColors.secondary,
              ),

              AccountTypeCard(
                icon: Icons.privacy_tip_outlined,
                route: 'AccountPrivacyScreen',
                title: tr("Account privacy"),
                isPrivateAccount: false,
              ),
              AccountTypeCard(
                  icon: Icons.delete,
                  route: DeleteAccountWidget(),
                  title: tr("Delete Account"),
                  isPrivateAccount: false),
            ].divide(const SizedBox(
              height: 16,
            )), // Dividing the cards with spacing.
          ),
        ),
      ),
    );
  }
}
