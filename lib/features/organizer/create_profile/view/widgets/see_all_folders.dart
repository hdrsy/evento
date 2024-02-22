import '../../../../../core/shared/models/media.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class SeeAllfolders extends StatelessWidget {
  const SeeAllfolders(
      {super.key, required this.allFolders, required this.handleOnTap});
  final RxList<FolderModel> allFolders;
  final Function(BuildContext context, FolderModel files, int folderIndex)
      handleOnTap;
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
      body: Obx(() => GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: allFolders.length,
          itemBuilder: (ctx, index) => SeeAllFolderCard(
                handleOnTap: () =>
                    handleOnTap(context, allFolders[index], index),
                folderIndex: index,
                folderModel: allFolders[index],
              ))),
    );
  }
}

class SeeAllFolderCard extends StatelessWidget {
  const SeeAllFolderCard(
      {super.key,
      required this.folderModel,
      required this.folderIndex,
      required this.handleOnTap});
  final FolderModel folderModel;
  final int folderIndex;
  final Function() handleOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleOnTap();
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
