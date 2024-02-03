import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/log_out_button_sheet.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/term_of_use.dart';
import '../../../../core/responsive/responsive.dart';

import '../../account_type_inner_screens/evento_verification_bottom_sheet/view/evento_verification_conditions_bottom_sheet.dart';
import '../controller/profile_controller.dart';
import 'widgets/build_image_with_name.dart';
import 'widgets/options_card.dart';
import 'widgets/switch_language.dart';
import 'widgets/theme_swicth.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              padding: padding(0, 16, 10, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildImageWithName(),
                  SizedBox(
                    height: scaleHeight(30),
                  ),
                  ThemeSwicth(),
                  ...List.generate(getnormalUserOptionsCard().length,
                      (index) => getnormalUserOptionsCard()[index]),
                  const SizedBox(
                    height: 12,
                  ),
                  Divider(
                    thickness: 1,
                    color: customColors.tertiary,
                  ),
                  OptionsCard(
                    targetRout: '/HelpCenterScreen',
                    icon: Icons.support_agent,
                    title: tr("Help Center"),
                  ),
                  OptionsCard(
                    targetRout: const TermOfUse(),
                    bottomSheetHeight: MediaQuery.of(context).size.height * 0.9,
                    icon: Icons.contact_support,
                    title: tr("Terms of Use"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Divider(
                    thickness: 1,
                    color: customColors.tertiary,
                  ),
                  OptionsCard(
                    targetRout: LogoutWidget(),
                    bottomSheetHeight: MediaQuery.of(context).size.height * 0.3,
                    icon: Icons.logout,
                    title: tr("Log Out"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

List<Widget> _buildUserSpecificOptions() {
  switch (user!.type) {
    case "normal" || "private":
      return getnormalUserOptionsCard();
    case "organizer":
      return getOrganizerOptionsCard();

    case "guest":
      return [
        // Options specific to organizer
      ];
    case "service provider":
      return [
        // Options specific to guest
      ];
    default:
      return [];
  }
}

List<Widget> getnormalUserOptionsCard() => [
      OptionsCard(
        targetRout: '/MyBookingScreen',
        icon: Icons.list,
        title: tr("My Bookings"),
      ),
      OptionsCard(
        targetRout: '/MyRequestScreen',
        icon: Icons.repeat,
        title: tr("My Requests"),
      ),
      OptionsCard(
        targetRout: '/FavoriteScreen',
        icon: Icons.favorite_border,
        title: tr("Favorite"),
      ),
      OptionsCard(
        targetRout: '/NotificationScreen',
        icon: Icons.notification_add_outlined,
        title: tr("Notifications"),
      ),
      OptionsCard(
        targetRout: '/ChangePasswordScreen',
        icon: Icons.password_outlined,
        title: tr("Change Password"),
      ),
      OptionsCard(
        targetRout: '/FreindsScreen',
        icon: Icons.group_outlined,
        title: tr("Friends"),
      ),
      //  OptionsCard(
      //   targetRout: '/InviteFreindsScreen',
      //   icon: Icons.groups_2_outlined,
      //   title: tr("Invite friends"),
      // ),
      OptionsCard(
        targetRout: '/SeeAllServiceCategoryScreen',
        icon: Icons.miscellaneous_services_outlined,
        title: tr("Service Provider"),
      ),
      OptionsCard(
        targetRout: '/AchivmentScreen',
        icon: Icons.code_sharp,
        title: tr("Achievements"),
      ),
      OptionsCard(
        targetRout: LanguageSelector(),
        icon: Icons.language_outlined,
        title: tr("Language"),
      ),
      OptionsCard(
        targetRout: '/AccountTypeScreen',
        icon: Icons.account_circle,
        title: tr("Account Type"),
      ),
    ];

List<Widget> getOrganizerOptionsCard() => [
      OptionsCard(
        targetRout: '/MyBookingScreen',
        icon: Icons.person_outline,
        title: tr("Organaizations Profile"),
      ),
      OptionsCard(
        targetRout: '/MyBookingScreen',
        icon: Icons.list,
        title: tr("My Bookings"),
      ),
      OptionsCard(
        targetRout: '/MyRequestScreen',
        icon: Icons.repeat,
        title: tr("My Requests"),
      ),
      OptionsCard(
        targetRout: '/MyRequestScreen',
        icon: Icons.celebration_outlined,
        title: tr("My Events"),
      ),
      OptionsCard(
        targetRout: '/FavoriteScreen',
        icon: Icons.favorite_border,
        title: tr("Favorite"),
      ),
      OptionsCard(
        targetRout: '/NotificationScreen',
        icon: Icons.notification_add_outlined,
        title: tr("Notifications"),
      ),
      OptionsCard(
        targetRout: '/ChangePasswordScreen',
        icon: Icons.password_outlined,
        title: tr("Change Password"),
      ),
      OptionsCard(
        targetRout: '/FreindsScreen',
        icon: Icons.group_outlined,
        title: tr("Friends"),
      ),
      OptionsCard(
        targetRout: '/InviteFreindsScreen',
        icon: Icons.groups_2_outlined,
        title: tr("Invite friends"),
      ),
      OptionsCard(
        targetRout: '/SeeAllServiceCategoryScreen',
        icon: Icons.miscellaneous_services_outlined,
        title: tr("Service Provider"),
      ),
      OptionsCard(
        targetRout: '/AchivmentScreen',
        icon: Icons.code_sharp,
        title: tr("Achievements"),
      ),
      OptionsCard(
        targetRout: LanguageSelector(),
        icon: Icons.language_outlined,
        title: tr("Language"),
      ),
      OptionsCard(
        targetRout: const EventVerificationCondidtionsBottomSheet(),
        bottomSheetHeight: screenHeight * 0.8,
        icon: Icons.account_circle,
        title: tr("Become Evento Verified "),
      ),
    ];
