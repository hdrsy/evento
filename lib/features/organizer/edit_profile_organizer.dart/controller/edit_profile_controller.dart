import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:evento/core/shared/models/media.dart';
import 'package:evento/features/organizer/organization_profile/model/organizer_profile_model.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../profile_pages/profile/model/profile_model.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileOrganizerController extends GetxController {
  late File customImage;
  late RxBool isImageSelected;
  late TextEditingController firstName;
  late TextEditingController bio;
  late TextEditingController createFolderName;

  late TextEditingController sepecialities;
  late String selectedState;
  late OrganizationProfileModel profileModel;
  late RxList<String> errorMessage;
  late GlobalKey<FormState> formstate;
  late List<String> states;
  late RxBool isLoading;
  late File? profileImage;
  late File? coverImage;
  late RxList<FolderModel> foldersModel;
  @override
  void onInit() {
    profileModel = Get.arguments;
    isImageSelected = false.obs;
    firstName = TextEditingController(text: profileModel.organizerInfo.name);
    createFolderName = TextEditingController();
    selectedState = profileModel.organizerInfo.state;
    bio = TextEditingController(text: profileModel.organizerInfo.bio);
    sepecialities =
        TextEditingController(text: profileModel.organizerInfo.services);
    isLoading = false.obs;
    foldersModel = <FolderModel>[].obs;
    formstate = GlobalKey<FormState>();
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

    super.onInit();
  }

  addMedia(RxList<MediaModel> newmedia) {
    if (newmedia.isEmpty) {
      foldersModel.removeLast();
    } else {
      foldersModel.last.mediaList.addAll(newmedia);
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

  onPressSaveChanging() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      errorMessage.clear();
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.updateProfile,
          method: "post",
          token: token,
          data: {"first_name": firstName.text, "state": selectedState},
          files: isImageSelected.value ? {"image": customImage} : null);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        whenGetDataSuccess(handlingResponse);
      }
      isLoading.value = false;
    }
  }

  whenGetDataSuccess(handlingResponse) {
    Get.back();
  }

  editMediaInsideFolder(int folderIndex, List<MediaModel> media) {
    print("inside media");
    foldersModel[folderIndex].mediaList.clear();
    foldersModel[folderIndex].mediaList.addAll(media);
    Get.back();
    print("editing complete");
  }

  deleteFolder(int folderIndex) {
    foldersModel.removeAt(folderIndex);
    print("inside deleteFolder");
  }

  onPressCreateFolder() {
    foldersModel
        .add(FolderModel(folderName: createFolderName.text, mediaList: []));
    createFolderName.clear();
    Get.back();
  }
}
