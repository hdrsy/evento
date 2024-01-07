import 'dart:developer';
import 'dart:io';

import 'package:evento/core/utils/services/compress_images.dart';
import 'package:evento/features/organizer/create_profile/controller/oganizer_create_profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaInFolderController extends GetxController {
  late String folderName;
  late int folderIndex;
  late RxList<File> attachedMedia;
  late RxList<File> attachedVideos;
  @override
  void onInit() {
    folderName = Get.arguments[0];
    folderIndex = Get.arguments[1];
    attachedMedia = <File>[].obs;
    super.onInit();
  }

  final imagePicker = ImagePicker();

  Future<void> pickVideo() async {
    final ImagePicker _picker = ImagePicker();
    // Pick a video
    final PickedFile? pickedFile =
        (await _picker.pickVideo(source: ImageSource.gallery))
            as PickedFile?; // or ImageSource.camera for capturing a new video

    if (pickedFile != null) {
      File videoFile = File(pickedFile.path);
      // Now you can use the video file for your needs
      attachedVideos.add(videoFile);
      OrganizerCreateProfileController organizerCreateProfileController =
          Get.find();

      organizerCreateProfileController.foldersModel[folderIndex].mediaList
          .add(MediaModel(mediaType: "video", media: videoFile));
      print("Video path: ${videoFile.path}");
      Get.back();
    } else {
      print('No video selected.');
    }
  }

  void pickNewMedia(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      attachedMedia.add(File(pickedImage.path));
      OrganizerCreateProfileController organizerCreateProfileController =
          Get.find();

      File originalImage = File(pickedImage.path);


      // Compress the image
      XFile? compressedImageXFile = await compressImage(originalImage);
      File? compressedImage;

      if (compressedImageXFile != null) {
        compressedImage = File(compressedImageXFile.path);
      }

      // Check if compression was successful
      if (compressedImage != null) {
        // Get compressed size
        int compressedSize = await compressedImage.length();
        print("Compressed Size: $compressedSize bytes");
        organizerCreateProfileController.foldersModel[folderIndex].mediaList
            .add(MediaModel(
                mediaType: "image", media: File(compressedImage.path)));

        Get.back();
      }
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
