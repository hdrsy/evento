import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:evento/core/shared/models/media.dart';
import 'package:evento/core/utils/services/compress_video.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/model/category_model.dart';
import 'package:evento/features/organizer/organization_profile/model/organizer_profile_model.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/becom_an_organizer/choice_oganizer_category/controller/choice_organizer_category_controller.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileOrganizerController extends GetxController {
  late File customImage;
  List<ChoiceOrganizerCategoryTypeModel> choiceServiceList = [];

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
  RxList<int> selectedCategories = <int>[].obs;

  @override
  void onInit() {
    profileModel = Get.arguments;
    isImageSelected = false.obs;
    firstName = TextEditingController(text: profileModel.name);
    createFolderName = TextEditingController();
    selectedState = profileModel.state;
    bio = TextEditingController(text: profileModel.bio);
    sepecialities = TextEditingController(text: profileModel.services);
    // foldersModel.assignAll(profileModel.albums);
    getCategoriesList();
    getSelectedGategories();
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

  getSelectedGategories() {
    for (var element in profileModel.categories) {
      selectedCategories.add(element.id);
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

  getCategoriesList() {
    final CategoryListController categoryListController = Get.find();
    List<CategoryModel> categories = [];
    categories.assignAll(categoryListController.categoryList);
    categories.removeAt(0);
    categories.removeAt(0);
    for (var element in categories) {
      choiceServiceList.add(ChoiceOrganizerCategoryTypeModel(
          name: element.title, categoryId: element.id));
    }
  }

  onPressDone() async {
    try {
      isLoading.value = true;
      // Before starting upload
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      Map<String, dynamic> dataRequest = {
        'name': firstName.text,
        'bio': bio.text,
        'covering_area': selectedState,
      };

      // for (int i = 0;
      //     i < choiceOrganizerCategoryController.selectedCategories.length;
      //     i++) {
      //   dataRequest["category_ids[$i]"] =
      //       choiceOrganizerCategoryController.selectedCategories[i];
      // }
      print(dataRequest);
      Map<String, File> fileMap = {};
      // if (profileImage != null) {
      //   fileMap['profile'] = profileImage!;
      // }
      // if (coverImage != null) {
      //   fileMap['cover'] = coverImage!;
      // }
      // if (foldersModel.isNotEmpty) {
      //   for (var i = 0; i < foldersModel.length; i++) {
      //     dataRequest['album-${i + 1}-name'] = foldersModel[i].folderName;
      //     for (int j = 0; j < foldersModel[i].mediaList.length; j++) {
      //       if (foldersModel[i].mediaList[j].mediaType == 'image') {
      //         fileMap['album-${i + 1}-images[$j]'] =
      //             foldersModel[i].mediaList[j].media;
      //       } else if (foldersModel[i].mediaList[j].mediaType == 'video') {
      //         File? compressedVideo =
      //             await compressVideo(foldersModel[i].mediaList[j].media);
      //         if (compressedVideo != null) {
      //           fileMap['album-${i + 1}-videos[$j]'] = compressedVideo;
      //         } else {
      //           // Handle the case where video compression fails
      //           // For example, you might choose to skip this file, log an error, or use the original file
      //           print(
      //               "Video compression failed for file: ${foldersModel[i].mediaList[j].media.path}");
      //         }
      //       }
      //     }
      //   }
      // }
      // print("before sending request ");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.organizationUpdateProfile,
          method: "POST",
          token: token,
          data: dataRequest,
          files: fileMap);
      print("the response is :$response");
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isLoading.value = false;
        print("object");
      } else {
        isLoading.value = false;
        print(handlingResponse);
        prefService.remove('userInfo');
        Get.offAllNamed('/home');
      }
      isLoading.value = false;
      isLoading.value = false;
    } catch (e) {
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
