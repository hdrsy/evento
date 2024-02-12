import 'package:evento/core/shared/controllers/screens/edit_folder.dart/controller/edit_folder_controller.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images_videos.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditMediaInFolderScreen extends StatelessWidget {
  EditMediaInFolderScreen({super.key});
  final EditFolderMediaController editFolderMedia =
      Get.put(EditFolderMediaController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(editFolderMedia.folderName,
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              editFolderMedia.onEditingComplete();
            },
            child: Icon(
              Icons.done_rounded,
              color: customColors.primaryText,
              size: 30,
            ),
          ),
        ],
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemCount: editFolderMedia.attachedMedia.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return AddMediaCard();
                    } else {
                      var mediaItem = editFolderMedia.attachedMedia[index - 1];
                      if (mediaItem.mediaType == "image") {
                        return Stack(
                          children: [
                            Image.file(mediaItem.media),
                            Positioned(
                                top: -5,
                                right: -5,
                                child: IconButton(
                                    onPressed: () {
                                      editFolderMedia
                                          .deleteMediafromList(index - 1);
                                    },
                                    icon: const Icon(Icons.cancel_outlined))),
                          ],
                        );
                      } else if (mediaItem.mediaType == "video") {
                        // Placeholder for video, adjust as necessary for your video player
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.file(mediaItem.media),
                            Icon(
                              Icons.play_circle_fill,
                              size: 50,
                              color: customColors.info,
                            ), // Placeholder icon
                            Positioned(
                                top: -0.5,
                                right: -0.5,
                                child: IconButton(
                                    onPressed: () {
                                      editFolderMedia
                                          .deleteMediafromList(index - 1);
                                    },
                                    icon: const Icon(Icons.cancel_outlined))),

                            // Implement your video player widget here
                          ],
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // Fallback for unknown media type
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddMediaCard extends StatelessWidget {
  AddMediaCard({super.key});
  final EditFolderMediaController editFolderMediaController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheetForImagesAndVideos(
            context: context,
            onPressCamera: () {
              Get.back();
              editFolderMediaController.pickNewMedia(ImageSource.camera);
            },
            onPressGallery: () async {
              Get.back();
              editFolderMediaController.pickNewMedia(ImageSource.gallery);
            },
            onPressVideo: () async {
              await Get.dialog(
                AlertDialog(
                  title: Text(
                    "Select Video",
                    style: customTextStyle.bodyMedium.override(
                        fontFamily: secondaryFontFamily,
                        useGoogleFonts: true,
                        color: customColors.primaryText,
                        fontSize: 16),
                  ),
                  content: Text(
                    "Please select a video that is no longer than 2 minutes.",
                    style: customTextStyle.bodyMedium.override(
                        fontFamily: secondaryFontFamily,
                        useGoogleFonts: true,
                        color: customColors.secondaryText,
                        fontSize: 14),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Get.back(); // Close the dialog
                        editFolderMediaController
                            .pickVideo(); // Proceed to pick the video
                      },
                    ),
                  ],
                ),
                barrierDismissible:
                    false, // Set to true if you want the dialog to be dismissible
              );
            });
      },
      child: Container(
        width: 50,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: customColors.primaryBackground, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: customColors.secondaryText,
            size: 50,
          ),
        ),
      ),
    );
  }
}
