import 'package:evento/core/shared/controllers/screens/edit_folder.dart/view/widgets/edit_folder_name.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/confirm_delete_folder.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/gallery/view/gallery_for_local_fies.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/controller/edit_profile_controller.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/view/widgets/see_all_folders.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/shared/models/media.dart';

class FolderCardEditOrganizerProfile extends StatelessWidget {
  final FolderModel folder;
  final int folderIndex;

  const FolderCardEditOrganizerProfile(
      {super.key, required this.folder, required this.folderIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/folder_card.png',
              height: 100.h,
              width: 100.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 100.h,
            child: Text(
              folder.folderName,
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(BuildContext context) async {
    // Example of handling tap, you can expand this method with your logic
    Get.to(() => GalleryForLocalScreen(
          files: RxList<MediaModel>(folder.mediaList),
          isEditgallery: true,
          deleteFolder: () => _deleteFolder(context),
          editFolderMedia: () => _editFolderMedia(context),
          showEditFolderName: () => _showEditFolderName(context),
        ));
  }

  void _deleteFolder(BuildContext context) {
    showDeleteConfirmation(context, () {
      Get.find<EditProfileOrganizerController>().deleteFolder(folderIndex);
      Get.back();
    });
  }

  void _editFolderMedia(BuildContext context) async {
    final result = await Get.toNamed('/EditMediaInFolderScreen', arguments: {
      'folderName': folder.folderName,
      'folderIndex': folderIndex,
      'mediaList': Get.find<EditProfileOrganizerController>()
          .foldersModel[folderIndex]
          .mediaList,
    });

    if (result != null) {
      Get.find<EditProfileOrganizerController>().editMediaInsideFolder(
          result['folderIndex'], result['updatedMediaList']);
    }
  }

  void _showEditFolderName(BuildContext context) {
    showButtonSheet(
      context: context,
      widget: EditFolderNameFolder(
        onPressDone: (String newFolderName) {
          Get.find<EditProfileOrganizerController>()
              .foldersModel[folderIndex]
              .folderName = newFolderName;
          folder.folderName = newFolderName;
        },
        folderName: TextEditingController(text: folder.folderName),
      ),
      height: 500.h,
    );
  }
}

class SeeAllFoldersCardEditOrganizerProfile extends StatelessWidget {
  SeeAllFoldersCardEditOrganizerProfile({super.key});
  final EditProfileOrganizerController organizerCreateProfileController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.to(SeeAllfoldersEditOrganizerProfile(
          handleOnTap: _handleTap,
          allFolders: RxList<FolderModel>(
              organizerCreateProfileController.foldersModel),
        ));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/folder_card.png',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
              // color: Colors.red,
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              boxShadow: [
                // BoxShadow(
                //   blurRadius: 4,
                //   color: Color(0x33000000),
                //   offset: Offset(0, 2),
                // )
              ],
            ),
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Text(
                "+${organizerCreateProfileController.foldersModel.length - 2}",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.info,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(
      BuildContext context, FolderModel files, int folderIndex) async {
    // Example of handling tap, you can expand this method with your logic
    Get.to(() => GalleryForLocalScreen(
          files: RxList<MediaModel>(files.mediaList),
          isEditgallery: true,
          deleteFolder: () => _deleteFolder(context, folderIndex),
          editFolderMedia: () => _editFolderMedia(context, files, folderIndex),
          showEditFolderName: () =>
              _showEditFolderName(context, files, folderIndex),
        ));
  }

  void _deleteFolder(BuildContext context, int folderIndex) {
    showDeleteConfirmation(context, () {
      Get.find<EditProfileOrganizerController>().deleteFolder(folderIndex);
      Get.back();
    });
  }

  void _editFolderMedia(
      BuildContext context, FolderModel folder, int folderIndex) async {
    final result = await Get.toNamed('/EditMediaInFolderScreen', arguments: {
      'folderName': folder.folderName,
      'folderIndex': folderIndex,
      'mediaList': Get.find<EditProfileOrganizerController>()
          .foldersModel[folderIndex]
          .mediaList,
    });

    if (result != null) {
      Get.find<EditProfileOrganizerController>().editMediaInsideFolder(
          result['folderIndex'], result['updatedMediaList']);
    }
  }

  void _showEditFolderName(
      BuildContext context, FolderModel folder, int folderIndex) {
    showButtonSheet(
      context: context,
      widget: EditFolderNameFolder(
        onPressDone: (String newFolderName) {
          Get.find<EditProfileOrganizerController>()
              .foldersModel[folderIndex]
              .folderName = newFolderName;
          folder.folderName = newFolderName;
        },
        folderName: TextEditingController(text: folder.folderName),
      ),
      height: 500.h,
    );
  }
}
