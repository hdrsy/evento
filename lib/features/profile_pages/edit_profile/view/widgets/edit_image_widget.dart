import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/edit_profile/controller/edit_profile_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditImageWidget extends StatelessWidget {
  EditImageWidget({super.key});
  final EditProfileController editProfileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: customColors.primaryBackground,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).width * 0.8,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child:Obx(()=> editProfileController.isImageSelected.value
                  ? Image.file(
                      editProfileController.customImage,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0.00, 0.00),
                    )
                  : Image.asset(
                      'assets/images/Asset_6.png',
                      fit: BoxFit.contain,
                      alignment: const Alignment(0.00, 0.00),
                    )),
            ),
          ),
        ),
        SizedBox(
          height: scaleHeight(15),
        ),
        ButtonWidget(
          onPressed: () async {
            showBottomSheetForImages(
                context: context,
                onPressCamera: () {
                  editProfileController
                      .pickImageForDashbard(ImageSource.camera);
                },
                onPressGallery: () async {
                  editProfileController
                      .pickImageForDashbard(ImageSource.gallery);
                });
          },
          text: "Change Photo",
          options: ButtonOptions(
            height: 35,
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.secondaryBackground,
            textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: customColors.primary,
              fontSize: 14,
              useGoogleFonts: true,
            ),
            elevation: 2,
            borderSide: BorderSide(
              color: customColors.primaryBackground,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            hoverColor: customColors.alternate,
            hoverBorderSide: BorderSide(
              color: customColors.alternate,
              width: 1,
            ),
            hoverTextColor: customColors.primaryText,
            hoverElevation: 3,
          ),
        )
      ],
    );
  }
}
