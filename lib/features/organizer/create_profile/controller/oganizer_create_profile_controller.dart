// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/models/media.dart';
import 'package:evento/core/shared/widgets/uploding/error_in_uploading.dart';
import 'package:evento/core/shared/widgets/uploding/start_uploading_data.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/helper/form_field_controller.dart';
import 'package:evento/core/utils/services/compress_video.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/becom_an_organizer/choice_oganizer_category/controller/choice_organizer_category_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrganizerCreateProfileController extends GetxController {
  late TextEditingController organizerName;
  late TextEditingController bio;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  FormFieldController<String> dropDownValueController =
      FormFieldController(null);
  late GlobalKey<FormState> formstate;

  late TextEditingController createFolderName;
  late List<String> states;
  late File? profileImage;
  late File? coverImage;
  late String? selectedState;
  late RxList<FolderModel> foldersModel;
  late Rx<double> uploadProgress;
  late RxString currentUploadingFile;
  @override
  void onInit() {
    organizerName = TextEditingController();
    bio = TextEditingController();
    createFolderName = TextEditingController();
    coverImage = null;
    profileImage = null;
    formstate = GlobalKey<FormState>();

    selectedState = null;
    isLoading = false.obs;
    uploadProgress = 0.0.obs;
    currentUploadingFile = ''.obs;
    errorMessage = <String>[].obs;

    states = [
      'Aleppo',
      'Al-Ḥasakah',
      'Al-Qamishli',
      'Al-Qunayṭirah',
      'Al-Raqqah',
      'Al-Suwayda',
      'Damascus',
      'Daraa',
      'Dayr al-Zawr',
      'Ḥamah',
      'Homs',
      'Idlib',
      'Latakia',
      'Rif Dimashq'
    ];
    foldersModel = <FolderModel>[].obs;
    super.onInit();
  }

  onPressCreateFolder() {
    foldersModel
        .add(FolderModel(folderName: createFolderName.text, mediaList: []));
    createFolderName.clear();
    Get.back();
  }

  addMedia(RxList<MediaModel> newmedia) {
    if (newmedia.isEmpty) {
      foldersModel.removeLast();
    } else {
      foldersModel.last.mediaList.addAll(newmedia);
    }
  }

  bool checkIfSelectedState() {
    List<String> errorList = [];
    if (selectedState == null && selectedState!.length < 2) {
      errorList.add("Please select your covering erea");
    }
    if (coverImage == null) {
      errorList.add("Please select your cover image");
    }
    if (profileImage == null) {
      errorList.add("Please select your profile image");
    }

    if (errorList.isEmpty) {
      return true;
    } else {
      Get.dialog(ErrorInUploading(
        errorMessaging: errorList,
      ));
      return false;
    }
  }

  final imagePicker = ImagePicker();
  void pickImageForDashbard(ImageSource imageSource, bool isProfile) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      isProfile
          ? profileImage = File(pickedImage.path)
          : coverImage = File(pickedImage.path);
      update();
      Get.back();
    }
  }

  onPressDone() async {
    try {
      isLoading.value = true;
      Get.dialog(startUploadingdata());
      // Before starting upload
      uploadProgress.value = 0.0; // Reset progress
      Either<ErrorResponse, Map<String, dynamic>> response;
      ChoiceOrganizerCategoryController choiceOrganizerCategoryController =
          Get.find();
      String token = await prefService.readString("token");
      Map<String, dynamic> dataRequest = {
        'name': organizerName.text,
        'bio': bio.text,

        'covering_area': selectedState!,
        'other_category': choiceOrganizerCategoryController.sericeSelected.text,
        // 'category_ids': choiceOrganizerCategoryController.selectedCategories
      };

      for (int i = 0;
          i < choiceOrganizerCategoryController.selectedCategories.length;
          i++) {
        dataRequest["category_ids[$i]"] =
            choiceOrganizerCategoryController.selectedCategories[i];
      }
      Map<String, File> fileMap = {};
      if (profileImage != null) {
        fileMap['profile'] = profileImage!;
      }
      if (coverImage != null) {
        fileMap['cover'] = coverImage!;
      }
      if (foldersModel.isNotEmpty) {
        for (var i = 0; i < foldersModel.length; i++) {
          dataRequest['album-${i + 1}-name'] = foldersModel[i].folderName;
          for (int j = 0; j < foldersModel[i].mediaList.length; j++) {
            currentUploadingFile.value =
                "Uploading: ${foldersModel[i].mediaList[j].media.path.split(Platform.pathSeparator).last}"; // Set current file name

            if (foldersModel[i].mediaList[j].mediaType == 'image') {
              fileMap['album-${i + 1}-images[$j]'] =
                  foldersModel[i].mediaList[j].media;
            } else if (foldersModel[i].mediaList[j].mediaType == 'video') {
              File? compressedVideo =
                  await compressVideo(foldersModel[i].mediaList[j].media);
              if (compressedVideo != null) {
                fileMap['album-${i + 1}-videos[$j]'] = compressedVideo;
              } else {
                // Handle the case where video compression fails
                // For example, you might choose to skip this file, log an error, or use the original file
              }
            }
          }
        }
      }
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.becomeOrganizer,
          method: "POST",
          token: token,
          data: dataRequest,
          files: fileMap);
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isLoading.value = false;
        Get.back();
        Get.dialog(ErrorInUploading(
          errorMessaging: errorMessage,
        ));
        currentUploadingFile.value = "uplading media field";
      } else {
        isLoading.value = false;
        prefService.remove('userInfo');
        currentUploadingFile.value = "All files uploaded successfully!";
        Get.offAllNamed('/home');
      }
      isLoading.value = false;
    } catch (e) {
      Get.back();
      isLoading.value = false;
    }
  }

  deleteFolder(int folderIndex) {
    foldersModel.removeAt(folderIndex);
  }

  editMediaInsideFolder(int folderIndex, List<MediaModel> media) {
    foldersModel[folderIndex].mediaList.clear();
    foldersModel[folderIndex].mediaList.addAll(media);
    Get.back();
  }
}
