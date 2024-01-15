import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/helper/date_formatter.dart';
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
  late TextEditingController sepecialities;
  late String selectedState;
  late ProfileModel profileModel;
  late RxList<String> errorMessage;
  late GlobalKey<FormState> formstate;
  late List<String> states;
  late RxBool isLoading;
  late File? profileImage;
  late File? coverImage;
  @override
  void onInit() {
    profileModel = Get.arguments[0];
    isImageSelected = false.obs;
    firstName = TextEditingController(text: profileModel.firstName);
    selectedState = profileModel.state;
    isLoading = false.obs;
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

  final imagePicker = ImagePicker();
  void pickImageForDashbard(ImageSource imageSource ,bool isProfile) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
    isProfile?profileImage=File(pickedImage.path):coverImage=File(pickedImage.path);
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
      String token = await prefService.readString("token") ?? "";
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.updateProfile,
          method: "post",
          token: token,
          data: {
            "first_name": firstName.text,
            "state": selectedState
          },
          files: isImageSelected.value ? {"image": customImage} : null);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      print(handlingResponse);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        whenGetDataSuccess(handlingResponse);
      }
      isLoading.value = false;
    }
  }

  whenGetDataSuccess(handlingResponse) {
    print(handlingResponse);
    Get.back();
  }
}