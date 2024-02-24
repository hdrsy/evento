import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/services/user_info.dart';
import 'package:evento/features/profile_pages/profile/controller/profile_controller.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';

import '../../profile/model/profile_model.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  late File customImage;
  late RxBool isImageSelected;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phone;
  late DateTime day;
  // late TextEditingController location;
  late String selectedState;
  late ProfileModel profileModel;
  late RxList<String> errorMessage;
  late GlobalKey<FormState> formstate;
  late List<String> states;
  late RxBool isLoading;
  late RxString genderSelected;
  @override
  void onInit() {
    profileModel = Get.arguments;
    isImageSelected = false.obs;
    firstName = TextEditingController(text: profileModel.firstName);
    lastName = TextEditingController(text: profileModel.lastName);
    day = profileModel.birthDate;
    phone = TextEditingController(text: profileModel.phoneNumber);
    // location = TextEditingController(text: profileModel.state);
    genderSelected = profileModel.gender.obs;
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
  void pickImageForDashbard(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      customImage = File(pickedImage.path);
      isImageSelected.value = true;

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
          data: {
            "first_name": firstName.text,
            "last_name": lastName.text,
            "phone_number": phone.text,
            "gender": genderSelected.value,
            "birth_date": DateFormat('yyyy/M/d').format(day),
            "state": selectedState
          },
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

  whenGetDataSuccess(handlingResponse) async {
    await prefService.remove("userInfo");
    user = await UserInfo.getUserInfo();
    final ProfileController profileController = Get.find();
    profileController.getProfileInfo();
    profileController.update();

    Get.back();
  }
}
