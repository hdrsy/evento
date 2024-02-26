// Importing necessary packages and widgets.
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/generale_dialog_message.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Defining the AccountTypeCard as a StatelessWidget.
class AccountTypeCard extends StatelessWidget {
  // Constructor with required properties: title, icon, and route.
  const AccountTypeCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.route,
      required this.isPrivateAccount});

  // Defining the properties.
  final String title;
  final IconData icon;
  // The route can be either a String or a Widget, not specifically typed.
  final route;
  final bool isPrivateAccount;
  @override
  // Building the widget.
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isPrivateAccount) {
          showGeneralMessage(
              "Feature not available with a private account. Please switch to a public setting to use this feature.",
              "");
        } else {
          // If the route is a String, navigate to it using Get.toNamed.
          if (route is String) {
            Get.toNamed('/$route');
          } else {
            // If the route is not a String, assume it's a Widget and show it in a bottom sheet.
            showButtonSheet(
                context: context,
                widget: route,
                height: MediaQuery.of(context).size.height * 0.3);
          }
        }
      },

      // Defining the card layout.
      child: Opacity(
        opacity: isPrivateAccount ? 0.5 : 1,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row for the icon and title.
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                  color: customColors.secondaryText,
                  size: 24,
                ),
                Text(
                  title,
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primaryText,
                    fontSize: 16,
                    useGoogleFonts: true,
                  ),
                ),
              ].divide(const SizedBox(
                  width: 5)), // Dividing icon and title with spacing.
            ),
            // Arrow icon indicating more details or navigation.
            Icon(
              Icons.arrow_forward_ios,
              color: customColors.secondaryText,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
