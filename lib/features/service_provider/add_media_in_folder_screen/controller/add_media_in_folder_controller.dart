import 'dart:developer';
import 'dart:io';

import '../../../../core/shared/models/media.dart';
import '../../../../core/utils/services/compress_video.dart';
import '../../service_provider_create_profile/controller/service_provider_create_profile_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaInFolderServiseProviderController extends GetxController {
  @override
  void onClose() {
    addAtatchedMediaToFolder();

    super.onClose();
  }

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
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedVideo =
        await _picker.pickVideo(source: ImageSource.gallery);

    return pickedVideo != null ? File(pickedVideo.path) : null;
  }

  void _showDurationExceededDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Select Video"),
        content:
            Text("Please select a video that is no longer than 2 minutes."),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _processSelectedVideo(File videoFile) async {
    attachedMedia.add({"video": await generateThumbnail(videoFile)});
    ServiceProviderCreateProfileController
        serviceProviderCreateProfileController = Get.find();
    serviceProviderCreateProfileController.foldersModel[folderIndex].mediaList
        .add(MediaModel(mediaType: "video", media: videoFile));
  }

  void pickNewMedia(ImageSource imageSource) async {
    if (imageSource == ImageSource.gallery) {
      final List<XFile>? pp = await imagePicker.pickMultiImage();
      if (pp != null) {
        for (var element in pp) {
          attachedMedia.add({"image": File(element.path)});
          ServiceProviderCreateProfileController
              serviceProviderCreateProfileController = Get.find();
          serviceProviderCreateProfileController
              .foldersModel[folderIndex].mediaList
              .add(MediaModel(mediaType: "image", media: File(element.path)));
        }
      }
    } else {
      final pickedImage = await imagePicker.pickImage(source: imageSource);
      if (pickedImage != null) {
        attachedMedia.add({"image": File(pickedImage.path)});
        ServiceProviderCreateProfileController
            serviceProviderCreateProfileController = Get.find();
        serviceProviderCreateProfileController
            .foldersModel[folderIndex].mediaList
            .add(MediaModel(mediaType: "image", media: File(pickedImage.path)));
      }
    }
  }

  addAtatchedMediaToFolder() {
    ServiceProviderCreateProfileController
        serviceProviderCreateProfileController = Get.find();
    if (attachedMedia.isEmpty) {
      serviceProviderCreateProfileController.foldersModel.removeAt(folderIndex);
    } else {
      log(serviceProviderCreateProfileController
          .foldersModel[folderIndex].mediaList.length
          .toString());
    }
  }

  deleteMediafromList(int mediaIndex) {
    attachedMedia.removeAt(mediaIndex);
    ServiceProviderCreateProfileController organizerCreateProfileController =
        Get.find();
    organizerCreateProfileController.foldersModel[folderIndex].mediaList
        .removeAt(mediaIndex);
  }
}
