import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/features/profile/view/widgets/build_image_with_name.dart';
import 'package:evento/features/profile/view/widgets/options_card.dart';
import 'package:evento/features/profile/view/widgets/theme_swicth.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  const OptionsCard(
                    targetRout: '/MyBookingScreen',
                    icon: Icons.list,
                    title: "My Bookings",
                  ),
                  const OptionsCard(
                    targetRout: '/MyRequestScreen',
                    icon: Icons.repeat,
                    title: "My Requests ",
                  ),
                  const OptionsCard(
                    targetRout: '/FavoriteScreen',
                    icon: Icons.favorite_border,
                    title: "Favorite",
                  ),
                  const OptionsCard(
                    targetRout: '/NotificationScreen',
                    icon: Icons.notification_add_outlined,
                    title: "Notifications",
                  ),
                  const OptionsCard(
                    targetRout: '',
                    icon: Icons.password_outlined,
                    title: "Change Password",
                  ),
                  const OptionsCard(
                    targetRout: '/FreindsScreen',
                    icon: Icons.group_outlined,
                    title: "Friends",
                  ),
                  const OptionsCard(
                    targetRout: '/InviteFreindsScreen',
                    icon: Icons.groups_2_outlined,
                    title: "Invite friends",
                  ),
                  const OptionsCard(
                    targetRout: '',
                    icon: Icons.language_outlined,
                    title: "Language",
                  ),
                  const OptionsCard(
                    targetRout: '/AccountTypeScreen',
                    icon: Icons.account_circle,
                    title: "Account Type",
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Divider(
                    thickness: 1,
                    color: customColors.tertiary,
                  ),
                  const OptionsCard(
                    targetRout: '/HelpCenterScreen',
                    icon: Icons.support_agent,
                    title: "Help Center",
                  ),
                  const OptionsCard(
                    targetRout: '',
                    icon: Icons.contact_support,
                    title: "Terms of Use",
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Divider(
                    thickness: 1,
                    color: customColors.tertiary,
                  ),
                  const OptionsCard(
                    targetRout: '',
                    icon: Icons.logout,
                    title: "Log Out ",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
