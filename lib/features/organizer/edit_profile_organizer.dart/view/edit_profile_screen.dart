import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/error_messages/error_messages.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/controller/edit_profile_controller.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/view/widgets/buttons.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/view/widgets/create_folder_organizer.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/view/widgets/edit_image_widget.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/view/widgets/fildes.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/view/widgets/folder_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileOrganizerScreen extends StatelessWidget {
  EditProfileOrganizerScreen({super.key});
  final EditProfileOrganizerController editProfileOrganizerController =
      Get.put(EditProfileOrganizerController());
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
        leading: GestureDetector(
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
      body:
          //  Obx(
          //   () =>
          SizedBox(
        width: double.infinity,
        child: Obx(
          () => SingleChildScrollView(
            padding: padding(20, 20, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EditImageWidgetOrganizer(),
                SizedBox(
                  height: 10.h,
                ),
                FieldsOrganizer(),
                OrganizerMediaCard(),
                ButtonsOrganizer(),
                ...List.generate(
                    editProfileOrganizerController.errorMessage.length,
                    (index) => ErrorMessages(
                          message: editProfileOrganizerController
                              .errorMessage[index],
                        )),
              ].divide(SizedBox(
                height: scaleHeight(15),
              )),
            ),
          ),
        ),
      ),
      // ),
    );
  }
}

class OrganizerMediaCard extends StatelessWidget {
  OrganizerMediaCard({
    super.key,
  });
  final EditProfileOrganizerController organizerCreateProfileController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 12),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: customColors.primaryBackground, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Text(
                    "Add new folders",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primary,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
                ),
                GestureDetector(
                  onTap: () async {
                    showButtonSheet(
                        context: context,
                        widget: CreateFolderEditOrganizer(),
                        height: 500);
                  },
                  child: const Icon(
                    Icons.add_circle_outline,
                    color: Color(0xFF757575),
                    size: 24,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                    //// for just show 3 item or less
                    organizerCreateProfileController.foldersModel.length > 3
                        ? 3
                        : organizerCreateProfileController.foldersModel.length,
                    (index) {
                  return (index == 2 &&
                          organizerCreateProfileController.foldersModel.length >
                              3)
                      ? SeeAllFoldersCardEditOrganizerProfile()
                      : FolderCardEditOrganizerProfile(
                          folder: organizerCreateProfileController
                              .foldersModel[index],
                          folderIndex: index,
                        );
                })
              ].divide(const SizedBox(
                width: 10,
              )),
            )
          ].divide(
            const SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}
