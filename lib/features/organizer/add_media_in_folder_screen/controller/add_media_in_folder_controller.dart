import 'dart:developer';
import 'dart:io';

import '../../../../core/shared/models/media.dart';
import '../../../../core/utils/services/compress_video.dart';
import '../../create_profile/controller/oganizer_create_profile_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaInFolderController extends GetxController {
  late String folderName;
  late int folderIndex;
  // late RxList<File> attachedMedia;
  // late RxList<File> attachedVideos;
  late RxList<Map<String, File>> attachedMedia;
  @override
  void onInit() {
    folderName = Get.arguments[0];
    folderIndex = Get.arguments[1];
    attachedMedia = <Map<String, File>>[].obs;
    super.onInit();
  }

  final imagePicker = ImagePicker();

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
    attachedMedia.add({"video": await generateThumbnail(videoFile)});
    OrganizerCreateProfileController organizerCreateProfileController =
        Get.find();
    organizerCreateProfileController.foldersModel[folderIndex].mediaList
        .add(MediaModel(mediaType: "video", media: videoFile));
  }

  void pickNewMedia(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      attachedMedia.add({"image": File(pickedImage.path)});
      OrganizerCreateProfileController organizerCreateProfileController =
          Get.find();
      organizerCreateProfileController.foldersModel[folderIndex].mediaList
          .add(MediaModel(mediaType: "image", media: File(pickedImage.path)));

      // }
    }
  }

  addAtatchedMediaToFolder() {
    OrganizerCreateProfileController organizerCreateProfileController =
        Get.find();
    if (attachedMedia.isEmpty) {
      organizerCreateProfileController.foldersModel.removeAt(folderIndex);
    } else {
      log(organizerCreateProfileController
          .foldersModel[folderIndex].mediaList.length
          .toString());
    }
  }
}
