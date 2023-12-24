import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController{
  late File customImage;
  late RxBool isImageSelected;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController date;
  late TextEditingController phone;
  late TextEditingController location;
  late TextEditingController gender;
@override
  void onInit() {
    isImageSelected=false.obs;
    firstName=TextEditingController();
    lastName=TextEditingController();
    date=TextEditingController();
    phone=TextEditingController();
    location=TextEditingController();
    gender=TextEditingController();
    super.onInit();
  }
  final imagePicker = ImagePicker();
  void pickImageForDashbard(ImageSource imageSource) async {

    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      customImage = File(pickedImage.path);
      isImageSelected.value=true;
      
      Get.back();
    }
  }
}