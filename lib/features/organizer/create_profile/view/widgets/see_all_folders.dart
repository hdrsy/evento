import 'dart:developer';

import '../../../../../core/shared/models/media.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../gallery/view/gallery_for_local_fies.dart';
import '../../controller/oganizer_create_profile_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class SeeAllfolders extends StatelessWidget {
  const SeeAllfolders({super.key, required this.allFolders});
  final List<FolderModel> allFolders;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("All Folders"),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
                allFolders.length,
                (index) => SeeAllFolderCard(
                      folderModel: allFolders[index],
                    ))
          ].divide(SizedBox(height: 10,)),
        ),
      ),
    );
  }
}

class SeeAllFolderCard extends StatelessWidget {
  const SeeAllFolderCard({super.key, required this.folderModel});
  final FolderModel folderModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // Get.toNamed('/GalleryScreen', arguments: album.images);
          Get.to(GalleryForLocalScreen(files: folderModel.mediaList,));
      
      },
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: const AlignmentDirectional(0, 0),
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(folderModel.mediaList[0].media,
                    width: double.infinity, height: 200)),
            Opacity(
              opacity: 0.4,
              child: Align(
                alignment: const AlignmentDirectional(0.11, 0.00),
                child: Container(
                  width: 342,
                  height: 200,
                  decoration: BoxDecoration(
                    color: customColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.01, -0.04),
              child: Text(
                folderModel.folderName,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  fontSize: 30,
                  useGoogleFonts: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
