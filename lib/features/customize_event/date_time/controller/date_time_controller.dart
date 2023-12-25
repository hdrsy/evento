import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DateTimeController extends GetxController{
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phoneNumber;
  late TextEditingController description;
  late int peopleNumber;
  late DateTime date;  
  late RxList<File> media;
 @override
  void onInit() {
    firstName=TextEditingController();
    lastName=TextEditingController();
    description=TextEditingController();
    phoneNumber=TextEditingController();
    media=<File>[].obs;
    super.onInit();
  } 
  
  final imagePicker = ImagePicker();
  void pickImageForDashbard(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      media.add( File(pickedImage.path)) ;
      ///// for isart the custom image iside avatar list on selected position
     
     
      Get.back();
    }
  }

}