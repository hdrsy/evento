import 'dart:io';

import 'package:evento/core/utils/helper/flutter_flow_util.dart';
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
  RxBool isEdit = false.obs;

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
    startTime = DateTime(2024, 3, 16);
    endTime = DateTime(2024, 3, 16);
    date = DateTime.now();

    errorMessage = <String>[].obs;
    super.onInit();
  }

  final imagePicker = ImagePicker();
  void pickNewMedia(ImageSource imageSource) async {
    if (imageSource == ImageSource.gallery) {
      final List<XFile>? pp = await imagePicker.pickMultiImage();
      if (pp != null) {
        for (var element in pp) {
          media.add(File(element.path));
        }
      }
    } else {
      final pickedImage = await imagePicker.pickImage(source: imageSource);
      if (pickedImage != null) {
        media.add(File(pickedImage.path));
      }
    }
  }

  onPressedNext() {
    if (date > DateTime.now() &&
        (adultNumber > 0 || childrenNumber > 0) &&
        startTime != "00:00 Am" &&
        endTime != "00:00 Am") {
      isUserEnterDateInfo = true;
    }
    FormState? formdata = formstate.currentState;
    if (formdata!.validate() && isUserEnterDateInfo && media.isNotEmpty) {
      formdata.save();
      if (isEdit.value) {
        Get.back();
      } else {
        Get.toNamed('/EventReviewScreen');
      }
    } else {
      Get.snackbar("Uncomplete data", "Please fill all the required data",
          snackPosition: SnackPosition.TOP,
          backgroundColor: customColors.primaryBackground,
          colorText: customColors.primaryText);
    }
  }

  fillContactInfo() {
    phoneNumber.text = user!.phoneNumber;
    firstName.text = user!.firstName;
    lastName.text = user!.lastName;
  }
}
