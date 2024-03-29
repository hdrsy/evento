import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/edit_profile_controller.dart';
import 'widgets/buttons.dart';
import 'widgets/edit_image_widget.dart';
import 'widgets/files.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final EditProfileController editProfileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Edit Profile"),
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
      body: Obx(
        () => SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: padding(20, 20, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EditImageWidget(),
                Fields(),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChanGender(
                        value: "male",
                      ),
                      ChanGender(
                        value: "female",
                      ),
                    ],
                  ),
                ),
                Buttons(),
                ...List.generate(
                    editProfileController.errorMessage.length,
                    (index) => ErrorMessages(
                          message: editProfileController.errorMessage[index],
                        )),
              ].divide(SizedBox(
                height: scaleHeight(15),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class ChanGender extends StatelessWidget {
  ChanGender({super.key, required this.value});
  final String value;
  final EditProfileController editProfileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            activeColor: customColors.primary,
            value: value,
            groupValue: editProfileController.genderSelected.value,
            onChanged: (newValue) {
              editProfileController.genderSelected.value = newValue!;
            },
          ),
          Text(value,
                  style: customTextStyle.bodyMedium
                      .override(fontFamily: primaryFontFamily, fontSize: 14))
              .tr(),
        ],
      ),
    );
  }
}
