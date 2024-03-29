import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/error_messages/error_messages.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../profile_pages/edit_profile/view/widgets/buttons.dart';
import '../../../profile_pages/edit_profile/view/widgets/edit_image_widget.dart';
import '../../../profile_pages/edit_profile/view/widgets/files.dart';
import '../controller/edit_profile_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileServiceProviderScreen extends StatelessWidget {
  EditProfileServiceProviderScreen({super.key});
  final EditProfileServiceProviderController
      editProfileServiceProviderController = Get.find();
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
                Buttons(),
                ...List.generate(
                    editProfileServiceProviderController.errorMessage.length,
                    (index) => ErrorMessages(
                          message: editProfileServiceProviderController
                              .errorMessage[index],
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
