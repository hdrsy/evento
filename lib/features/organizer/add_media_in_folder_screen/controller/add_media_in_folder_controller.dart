import 'dart:io';

import '../../../../core/shared/models/media.dart';
import '../../../../core/utils/services/compress_video.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaInFolderController extends GetxController {
  @override
  void onClose() {
    attachedMediaCallBack(attachedMedia);
    super.onClose();
  }

  late String folderName;
  late int folderIndex;
  // late RxList<File> attachedMedia;
  // late RxList<File> attachedVideos;
  late RxList<MediaModel> attachedMedia;
  late Function(RxList<MediaModel> media) attachedMediaCallBack;

  @override
  void onInit() {
    folderName = Get.arguments[0];
    folderIndex = Get.arguments[1];
    attachedMedia = Get.arguments[2] ?? <MediaModel>[].obs;
    attachedMediaCallBack = Get.arguments[3];
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
    attachedMedia.add(MediaModel(
        mediaType: "video", media: await generateThumbnail(videoFile)));
  }

  void pickNewMedia(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      attachedMedia
          .add(MediaModel(mediaType: "image", media: File(pickedImage.path)));
    }
  }

  deleteMediafromList(int mediaIndex) {
    attachedMedia.removeAt(mediaIndex);
  }
}
