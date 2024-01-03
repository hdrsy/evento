import 'dart:io';

import 'package:evento/main.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DateTimeController extends GetxController {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phoneNumber;
  late TextEditingController description;
  late TextEditingController eventTitle;
  late RxInt adultNumber;
  late RxInt childrenNumber;
  late DateTime date;
  late RxList<File> media;
  late DateTime startTime;
  late DateTime endTime;
  late GlobalKey<FormState> formstate;
  bool isUserEnterDateInfo = false;
  late RxList<String> errorMessage;

  @override
  void onInit() {
    formstate = GlobalKey<FormState>();
    firstName = TextEditingController();
    lastName = TextEditingController();
    description = TextEditingController();
    phoneNumber = TextEditingController();
    eventTitle = TextEditingController();
    media = <File>[].obs;
    adultNumber = 0.obs;
    childrenNumber = 0.obs;
    startTime = DateTime.now();
    endTime = DateTime.now();
    date = DateTime.now();

    errorMessage = <String>[].obs;
    super.onInit();
  }

  final imagePicker = ImagePicker();
  void pickImageForDashbard(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      media.add(File(pickedImage.path));
      ///// for isart the custom image iside avatar list on selected position

      Get.back();
    }
  }

  onPressedNext() {
    // FormState? formdata = formstate.currentState;
    // if (formdata!.validate() && isUserEnterDateInfo) {
    //   formdata.save();
      Get.toNamed('/ServiceCategoryScreen');
    // } else {
    //   Get.snackbar("Uncomplete data", "Please fill all the required data",
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: customColors.primaryBackground,
    //        colorText: customColors.primaryText
    //       );
    // }
  }
}
