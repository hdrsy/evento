import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/profile_pages/invite_friends/view/widgets/accept_invit_list.dart';
import 'package:evento/features/profile_pages/invite_friends/view/widgets/bar_code_widget.dart';
import 'package:evento/features/profile_pages/invite_friends/view/widgets/invited_friends_text.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Freinds",
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: padding(0,24,0,24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: scaleHeight(16),),
      const InvitedfriendsText(),
      const BarCodeWidget(),
      const AcceptInvitList()
          ].divide(const SizedBox(height: 16,)),
        )),
      ),
      );
  }
}