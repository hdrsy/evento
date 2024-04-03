import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
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
  bool isStartEndDateValid = false;
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
    isStartEndDateValid = endTime.isAfter(startTime);
    if (date > DateTime.now() &&
        (adultNumber.value + childrenNumber.value > 0) &&
        isStartEndDateValid &&
        media.length > 0) {
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
      if (!isStartEndDateValid) {
        Get.snackbar(tr("Time Selection Error"),
            tr("The end time must be later than the start time. Please adjust your selection to continue."),
            snackPosition: SnackPosition.TOP,
            backgroundColor: customColors.primaryBackground,
            colorText: customColors.primaryText);
      } else if (adultNumber.value + childrenNumber.value == 0) {
        Get.snackbar(
            tr("Number Of Guest Error"), tr("The number of guest is required"),
            snackPosition: SnackPosition.TOP,
            backgroundColor: customColors.primaryBackground,
            colorText: customColors.primaryText);
      } else if (media.length == 0) {
        Get.snackbar(tr("Upload Media Required"),
            tr("The media is required at least one item"),
            snackPosition: SnackPosition.TOP,
            backgroundColor: customColors.primaryBackground,
            colorText: customColors.primaryText);
      } else {
        Get.snackbar(
            tr("Uncomplete data"), tr("Please fill all the required data"),
            snackPosition: SnackPosition.TOP,
            backgroundColor: customColors.primaryBackground,
            colorText: customColors.primaryText);
      }
    }
  }

  fillContactInfo() {
    phoneNumber.text = user!.phoneNumber;
    firstName.text = user!.firstName;
    lastName.text = user!.lastName;
  }
}
