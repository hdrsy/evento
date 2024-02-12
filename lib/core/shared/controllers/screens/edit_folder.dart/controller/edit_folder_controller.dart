import 'dart:developer';
import 'dart:io';

import 'package:evento/core/shared/models/media.dart';
import 'package:evento/core/utils/services/compress_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditFolderMediaController extends GetxController {
  @override
  void onClose() {
    addAtatchedMediaToFolder();
    super.onClose();
  }

  late String folderName;
  late int folderIndex;
  // late RxList<File> attachedMedia;
  // late RxList<File> attachedVideos;
  late RxList<MediaModel> attachedMedia;
  @override
  void onInit() {
    // Accessing the entire arguments map
    final args = Get.arguments as Map<String, dynamic>;

    // Extracting individual arguments
    folderName = args['folderName'];
    folderIndex = args['folderIndex'];
    List<MediaModel> mediaList =
        args['mediaList']; // Assume this comes from the create profile screen;

// When passing to the editing screen or assigning to an RxList, convert it:
    attachedMedia = RxList<MediaModel>(mediaList);

    super.onInit();
  }

  final imagePicker = ImagePicker();
  onEditingComplete() {
    Get.back(result: {
      'folderIndex': folderIndex,
      'updatedMediaList': attachedMedia,
    });
  }

  Future<void> pickVideo() async {
    File? videoFile = await _selectVideoFromGallery();
    if (videoFile == null) {
      return;
    }

    Duration? videoDuration = await getVideoDuration(videoFile);
    if (videoDuration == null) {
      return;
    }

    if (videoDuration.inSeconds / 1000 > 120) {
      _showDurationExceededDialog();
      return;
    }

    await _processSelectedVideo(videoFile);
  }

  Future<File?> _selectVideoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedVideo =
        await picker.pickVideo(source: ImageSource.gallery);

    return pickedVideo != null ? File(pickedVideo.path) : null;
  }

  void _showDurationExceededDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Select Video"),
        content: const Text(
            "Please select a video that is no longer than 2 minutes."),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _processSelectedVideo(File videoFile) async {
    attachedMedia.add(MediaModel(
        media: await generateThumbnail(videoFile), mediaType: "video"));
  }

  void pickNewMedia(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      attachedMedia
          .add(MediaModel(mediaType: "image", media: File(pickedImage.path)));

      // }
    }
  }

  addAtatchedMediaToFolder() {
    // OrganizerCreateProfileController organizerCreateProfileController =
    //     Get.find();
    // if (attachedMedia.isEmpty) {
    //   organizerCreateProfileController.foldersModel.removeAt(folderIndex);
    // } else {
    //   log(organizerCreateProfileController
    //       .foldersModel[folderIndex].mediaList.length
    //       .toString());
    // }
  }

  deleteMediafromList(int mediaIndex) {
    attachedMedia.removeAt(mediaIndex);
  }
}
