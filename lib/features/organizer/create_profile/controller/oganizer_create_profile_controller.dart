// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/services/compress_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'package:evento/core/server/server_config.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/becom_an_organizer/choice_oganizer_category/controller/choice_organizer_category_controller.dart';
import 'package:evento/main.dart';

class OrganizerCreateProfileController extends GetxController {
  late TextEditingController organizerName;
  late TextEditingController bio;
  late RxList<String> errorMessage;
  late RxBool isLoading;

  late TextEditingController createFolderName;
  late List<String> states;
  late File? profileImage;
  late File? coverImage;
  late String? selectedState;
  late RxList<FolderModel> foldersModel;
  @override
  void onInit() {
    organizerName = TextEditingController();
    bio = TextEditingController();
    createFolderName = TextEditingController();
    coverImage = null;
    profileImage = null;
    selectedState = null;
    isLoading = false.obs;
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

  final imagePicker = ImagePicker();
  void pickImageForDashbard(ImageSource imageSource, bool isProfile) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      isProfile == true
          ? profileImage = File(pickedImage.path)
          : coverImage = File(pickedImage.path);
      ///// for isart the custom image iside avatar list on selected position
      update();
      Get.back();
    }
  }

  onPressDone() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    ChoiceOrganizerCategoryController choiceOrganizerCategoryController =
        Get.find();
    String token = await prefService.readString("token") ?? "";
    Map<String, dynamic> dataRequest = {
      'name': organizerName.text,
      'bio': bio.text,
      'state': selectedState!,
      'services': "selectedState",
      'category_id': "1"
    };
    Map<String, File> fileMap = {};
    for (var i = 0; i < foldersModel.length; i++) {
      dataRequest['album-${i + 1}-name'] = foldersModel[i].folderName;
      for (int j = 0; j < foldersModel[i].mediaList.length; j++) {
        if (foldersModel[i].mediaList[j].mediaType == 'image') {
          fileMap['album-${i + 1}-images[$j]'] =
              foldersModel[i].mediaList[j].media;
        } else if (foldersModel[i].mediaList[j].mediaType == 'video') {
          File? compressedVideo = await compressVideo(foldersModel[i].mediaList[j].media);
      if (compressedVideo != null) {
        fileMap['album-${i + 1}-videos[$j]'] = compressedVideo;
      } else {
        // Handle the case where video compression fails
        // For example, you might choose to skip this file, log an error, or use the original file
        print("Video compression failed for file: ${foldersModel[i].mediaList[j].media.path}");
      } }
      }
    }
    print(fileMap.length);
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
      print("object");
    } else {
      isLoading.value=false;
      print(handlingResponse);
Get.offAllNamed('/home');
}
  }

  }

class FolderModel {
  final String folderName;
  List<MediaModel> mediaList;
  FolderModel({
    required this.folderName,
    required this.mediaList,
  });
}

class MediaModel {
  String mediaType;
  File media;
  MediaModel({
    required this.mediaType,
    required this.media,
  });
}
