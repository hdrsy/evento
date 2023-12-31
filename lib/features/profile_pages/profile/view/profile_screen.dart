import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/features/profile_pages/profile/controller/profile_controller.dart';
import 'package:evento/features/profile_pages/profile/view/widgets/build_image_with_name.dart';
import 'package:evento/features/profile_pages/profile/view/widgets/options_card.dart';
import 'package:evento/features/profile_pages/profile/view/widgets/switch_language.dart';
import 'package:evento/features/profile_pages/profile/view/widgets/theme_swicth.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
final ProfileController profileController=Get.find();
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
                    targetRout: '/AccountTypeScreen',
                    icon: Icons.account_circle,
                    title: tr("Account Type"),
                  ),
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
                    targetRout: '',
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
                    targetRout: '/',
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
