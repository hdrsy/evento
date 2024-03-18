// Importing necessary packages and widgets.
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/account_privacy/controller/account_privacy_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// Defining the AccountPrivacyScreen as a StatelessWidget.
class AccountPrivacyScreen extends StatelessWidget {
  // Constructor with optional key parameter.
  AccountPrivacyScreen({super.key});

  // Creating an instance of AccountPrivacyController and registering it with GetX.
  final AccountPrivacyController accountPrivacyController =
      Get.put(AccountPrivacyController());

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
          "Account Privacy",
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
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          // Applying padding around the content.
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row for the "Private account" switch and its label.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Private account",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primaryText,
                      fontSize: 16,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
                  // Observing changes in the AccountPrivacyController.
                  Obx(
                    () => Switch.adaptive(
                      applyCupertinoTheme: true,
                      value: accountPrivacyController.isAccountPrivate.value,
                      onChanged: (newValue) {
                        accountPrivacyController.changeAccoutPrivacy();
                      },
                      activeColor: customColors.primary,
                      activeTrackColor: customColors.primaryBackground,
                      inactiveTrackColor: customColors.alternate,
                      inactiveThumbColor: customColors.secondaryText,
                    ),
                  )
                ],
              ),
              // Aligning the description text.
              Align(
                alignment: const AlignmentDirectional(-1, -1),
                child: Text(
                  "Switching your account to private hides your attendance at events and the list of accounts you follow. This ensures your engagement and connections remain private, not visible to the public.",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.secondaryText,
                    fontSize: 14,
                    useGoogleFonts: true,
                  ),
                ).tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
