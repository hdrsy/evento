// Importing necessary packages and widgets.
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/evento_verification_bottom_sheet/view/widgets/waitlist_confirmation_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

// Defining the EventVerificationCondidtionsBottomSheet as a StatelessWidget.
class EventVerificationCondidtionsBottomSheet extends StatelessWidget {
  // Constructor with optional key parameter.
  const EventVerificationCondidtionsBottomSheet({super.key});

  @override
  // Building the widget.
  Widget build(BuildContext context) {
    return Container(
      // Setting the background color of the container.
      color: customColors.secondaryBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              // Applying padding around the content.
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Small divider at the top.
                  SizedBox(
                    width: 50,
                    child: Divider(
                      thickness: 3,
                      color: customColors.secondary,
                    ),
                  ),
                  // Title text of the bottom sheet.
                  titleText(context, 'Join the waitlist for ُEvento Verified'),
                  // Body text describing Evento Verified.
                  bodyText(context, 'Establish your presence and get access to exclusive benefits with Evento Verified. Learn more', true),
                  // Info section with rows of information.
                  infoSection(context),
                  // Body text with age restriction information.
                  bodyText(context, 'Evento Verified is not available for people younger than 18 years of age.', false),
                ].divide(const SizedBox(height: 15,)), // Dividing widgets with spacing.
              ),
            ),
          ),
          // Padding for the join waitlist button.
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
            child: ButtonWidget(
              onPressed: () async {
                // Showing a bottom sheet on button press.
                showButtonSheet(
                  context: context, 
                  widget: const WaitlistConfirmationWidget(), 
                  height: MediaQuery.sizeOf(context).height * 0.6
                );
              },
              text: "Join waitlist",
              options: ButtonOptions(
                width: 200,
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: customColors.primary,
                textStyle: customTextStyle.titleSmall.override(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  useGoogleFonts: true,
                ),
                elevation: 3,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Function to create a title text widget.
Widget titleText(BuildContext context, String title) {
  // Aligning the title text at the center.
  return Align(
    alignment: const AlignmentDirectional(0, -1),
    child: Text(
      title,
      style: customTextStyle.bodyMedium.override(
        fontFamily: 'Nunito',
        color: customColors.primaryText,
        fontSize: 25,
        fontWeight: FontWeight.w600,
        useGoogleFonts: false,
      ),
    ),
  );
}

// Function to create a body text widget.
Widget bodyText(BuildContext context, String textKey, bool isPrimarytext) {
  // Aligning the body text at the center.
  return Align(
    alignment: const AlignmentDirectional(0, 0),
    child: Text(
      textKey,
      textAlign: TextAlign.start,
      style: customTextStyle.bodySmall.override(
        fontFamily: 'Nunito',
        color: isPrimarytext ? customColors.primaryText : customColors.primary, // Different color based on the parameter.
        useGoogleFonts: false,
      ),
    ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!), // Applying animation on page load.
  );
}

// Function to create an info section with rows of information.
Widget infoSection(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      // Each row contains an icon, title, and subtitle.
      infoRow(context, Icons.verified_outlined, 'A verified badge', 'Your audience can trust that you\'re a real person sharing your real stories.'),
      infoRow(context, Icons.security_sharp, 'Increased account protection', 'Worry less about impersonation with proactive identity monitoring.'),
      infoRow(context, Icons.support_agent_outlined, 'Support when you need it', 'Get answers more quickly about the things that matter to you. Right now, support is only available in some languages'),
      infoRow(context, Icons.verified_outlined, 'Unique stickers', 'Express yourself with stickers only available to Evento Verified subscribers.'),
    ].divide(const SizedBox(height: 18,)), // Dividing rows with spacing.
  );
}

// Function to create a row in the info section.
Widget infoRow(
    BuildContext context, IconData icon, String titleKey, String subtitleKey) {
  return InkWell(
    // Configuring the visual feedback on interaction.
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () async {

    },
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon for the row.
        Icon(icon, color: customColors.secondaryText, size: 24),
        // Expanded widget to align text next to the icon.
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title text of the row.
              Text(
                titleKey,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  fontSize: 16,
                  useGoogleFonts: true,
                ),
              ),
              // Subtitle text of the row.
              Text(
                subtitleKey,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.secondaryText,
                  fontSize: 14,
                  useGoogleFonts: true,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
