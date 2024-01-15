import '../../../../../core/shared/models/media.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../gallery/view/gallery_for_local_fies.dart';
import '../../../../organizer/create_profile/view/widgets/see_all_folders.dart';
import '../../controller/service_provider_create_profile_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderCard extends StatelessWidget {
  const FolderCard({super.key, required this.folder});
  final FolderModel folder;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // Get.toNamed("/GalleryScreen");
        Get.to(GalleryForLocalScreen(files: folder.mediaList,));
      },
      child:
Column(
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
)

    );
  }
}


class SeeAllFoldersCard extends StatelessWidget {
   SeeAllFoldersCard({super.key});
final ServiceProviderCreateProfileController serviceProviderCreateProfileController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        Get.to(SeeAllfolders(allFolders: serviceProviderCreateProfileController.foldersModel,));
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
                "+${serviceProviderCreateProfileController.foldersModel.length-2}",
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