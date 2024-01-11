import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/features/profile_pages/profile/model/profile_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileServiceProviderController extends GetxController {
  late File customImage;
  late RxBool isImageSelected;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController date;
  late TextEditingController phone;
  // late TextEditingController location;
  late String selectedState;
  late TextEditingController gender;
  late ProfileModel profileModel;
  late RxList<String> errorMessage;
  late GlobalKey<FormState> formstate;
  late List<String> states;
  late RxBool isLoading;
  late File? profileImage;
  late File? coverImage;
  
  @override
  void onInit() {
    profileModel = Get.arguments;
    isImageSelected = false.obs;
    firstName = TextEditingController(text: profileModel.firstName);
    lastName = TextEditingController(text: profileModel.lastName);
    date = TextEditingController(
        text: DateFormatter.formatDate(profileModel.birthDate));
    phone = TextEditingController(text: profileModel.phoneNumber);
    // location = TextEditingController(text: profileModel.state);
    gender = TextEditingController(text: profileModel.gender);
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
            "last_name": lastName.text,
            "phone_number": phone.text,
            // "gender": firstName.text,
            // "birth_date": date.text,
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
