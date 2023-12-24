import 'dart:developer';
import 'dart:io';

import 'package:evento/features/organizer/create_profile/controller/oganizer_create_profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaInFolderController extends GetxController{
  late String folderName;late int folderIndex;
  late RxList<File> attachedMedia;
  @override
  void onInit() {
    folderName=Get.arguments[0];
    folderIndex=Get.arguments[1];
    attachedMedia=<File>[].obs;
    super.onInit();
  }
    final imagePicker = ImagePicker();
  void pickNewMedia(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      attachedMedia.add(File(pickedImage.path));
      Get.back();
    }
  }
  addAtatchedMediaToFolder(){
    OrganizerCreateProfileController organizerCreateProfileController=Get.find();
    organizerCreateProfileController.foldersModel[folderIndex].mediaList.addAll( attachedMedia);
    log(organizerCreateProfileController.foldersModel[folderIndex].mediaList.length.toString());
  }

}