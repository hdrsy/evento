// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/shared/models/media.dart';
import 'package:evento/core/shared/widgets/uploding/error_in_uploading.dart';
import 'package:evento/core/shared/widgets/uploding/start_uploading_data.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/services/compress_video.dart';
import 'package:evento/features/profile_pages/account_type_inner_screens/switch_to_service_provider/view/anther_screens/choice_service_type/controller/choice_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:evento/core/server/server_config.dart';
import 'package:evento/main.dart';

class ServiceProviderCreateProfileController extends GetxController {
  late TextEditingController organizerName;
  late TextEditingController bio;
  late TextEditingController description;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  late GlobalKey<FormState> formstate;

  late TextEditingController createFolderName;
  late List<String> states;
  late File? profileImage;
  late File? coverImage;
  late String? selectedState;
  late RxList<FolderModel> foldersModel;
  late LatLng? locationData;
  @override
  void onInit() {
    locationData = null;
    organizerName = TextEditingController();
    bio = TextEditingController();
    description = TextEditingController();
    createFolderName = TextEditingController();
    coverImage = null;
    profileImage = null;
    selectedState = null;
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    formstate = GlobalKey<FormState>();

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

  bool checkIfSelectedState() {
    if (selectedState != null && selectedState!.length > 2) {
      return true;
    } else {
      Get.dialog(const ErrorInUploading(
        errorMessaging: ["Please select your covering erea"],
      ));
      return false;
    }
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
    try {
      isLoading.value = true;
      Get.dialog(startUploadingdata());

      Either<ErrorResponse, Map<String, dynamic>> response;
      ChoiceTypeController choiceTypeController = Get.find();
      String token = await prefService.readString("token");
      Map<String, dynamic> dataRequest = {
        'name': organizerName.text,
        'name_ar': organizerName.text,
        'bio': bio.text,
        'bio_ar': bio.text,
        'location_work_governorate': selectedState!,
        'description': description.text,
        'description_ar': description.text,
        'category_id': choiceTypeController.selectedService.value,
      };
      locationData != null
          ? dataRequest['latitude'] = locationData!.latitude
          : null;
      locationData != null
          ? dataRequest['longitude'] = locationData!.longitude
          : null;
      Map<String, File> fileMap = {};
      if (profileImage != null) {
        fileMap['profile'] = profileImage!;
      }
      if (coverImage != null) {
        fileMap['cover'] = coverImage!;
      }

      for (var i = 0; i < foldersModel.length; i++) {
        dataRequest['album-${i + 1}-name'] = foldersModel[i].folderName;
        for (int j = 0; j < foldersModel[i].mediaList.length; j++) {
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
              print(
                  "Video compression failed for file: ${foldersModel[i].mediaList[j].media.path}");
            }
          }
        }
      }
      print(fileMap.length);
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.becomeServiceProvider,
          method: "POST",
          token: token,
          data: dataRequest,
          files: fileMap);
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      print(handlingResponse);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        isLoading.value = false;
        Get.back();
        Get.dialog(ErrorInUploading(
          errorMessaging: errorMessage,
        ));
        print("object");
      } else {
        isLoading.value = false;
        print(handlingResponse);
        Get.offAllNamed('/home');
      }
    } catch (e) {
      print("ecption $e");
      Get.back();
      isLoading.value = false;
    }
  }

  editMediaInsideFolder(int folderIndex, List<MediaModel> media) {
    print("inside media");
    foldersModel[folderIndex].mediaList.clear();
    foldersModel[folderIndex].mediaList.addAll(media);
    update();
    Get.back();
    print("editing complete");
  }

  deleteFolder(int folderIndex) {
    foldersModel.removeAt(folderIndex);
    print("inside deleteFolder");
  }
}
