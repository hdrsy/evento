import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/edit_profile/controller/edit_profile_controller.dart';
import 'package:evento/features/edit_profile/view/widgets/buttons.dart';
import 'package:evento/features/edit_profile/view/widgets/change_password_button.dart';
import 'package:evento/features/edit_profile/view/widgets/edit_image_widget.dart';
import 'package:evento/features/edit_profile/view/widgets/files.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final EditProfileController editProfileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Edit Profile",
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
          padding: padding(20, 20, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EditImageWidget(),
             Fields(),
             const ChangePasswordButton(),
             const Buttons()
            ].divide(SizedBox(height: scaleHeight(15),)),
          ),
        ),
      ),
    );
  }
}
