import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images_videos.dart';
import 'package:evento/features/organizer/add_media_in_folder_screen/controller/add_media_in_folder_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaInFolderScreen extends StatelessWidget {
  AddMediaInFolderScreen({super.key});
  final AddMediaInFolderController addMediaInFolderController =
      Get.put(AddMediaInFolderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(addMediaInFolderController.folderName,
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            addMediaInFolderController.addAtatchedMediaToFolder();
            Get.back();
            // Get.back();
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
                  itemCount:
                      addMediaInFolderController.attachedMedia.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return AddMediaCard();
                    } else {
                      var mediaItem =
                          addMediaInFolderController.attachedMedia[index - 1];
                      if (mediaItem.containsKey("image")) {
                        return Image.file(mediaItem["image"]!);
                      } else if (mediaItem.containsKey("video")) {
                        // Placeholder for video, adjust as necessary for your video player
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.file(mediaItem["video"]!),
                            Icon(Icons.play_circle_fill), // Placeholder icon
                            // Implement your video player widget here
                          ],
                        );
                      } else {
                        return SizedBox
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
  final AddMediaInFolderController addMediaInFolderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomSheetForImagesAndVideos(
            context: context,
            onPressCamera: () {
              addMediaInFolderController.pickNewMedia(ImageSource.camera);
            },
            onPressGallery: () async {
              addMediaInFolderController.pickNewMedia(ImageSource.gallery);
            },
            onPressVideo: () async {
              addMediaInFolderController.pickVideo();
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
