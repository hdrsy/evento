import '../../../../../core/shared/models/media.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../gallery/view/gallery_for_local_fies.dart';
import '../../controller/oganizer_create_profile_controller.dart';
import 'see_all_folders.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderCard extends StatelessWidget {
  const FolderCard({super.key, required this.folder});
  final FolderModel folder;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          // Get.toNamed("/GalleryScreen");
          Get.to(GalleryForLocalScreen(
            files: folder.mediaList,
          ));
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
            Text(
              folder.folderName,
              style: customTextStyle.bodyMedium,
            ),
          ].divide(SizedBox(height: 5)),
        ));
  }
}

class SeeAllFoldersCard extends StatelessWidget {
  SeeAllFoldersCard({super.key});
  final OrganizerCreateProfileController organizerCreateProfileController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.to(SeeAllfolders(
          allFolders: organizerCreateProfileController.foldersModel,
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
}
