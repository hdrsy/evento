import 'dart:io';

import 'package:evento/features/auth/steps/controller/page_controller.dart';
import '../../step7/model/interst_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class StepsController extends GetxController {
  late RxBool isMale;
  late RxList<dynamic> avatarList;
  late List<InterestItem> interestList;
  late File customImage;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late GlobalKey<FormState> passwordformstate;
  late bool turnOnNotification;
  DateTime? day;
  RxString dateErrorMessage = ''.obs;
  late int selectedProfileindex;
  @override
  void onInit() {
    passwordformstate = GlobalKey<FormState>();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    turnOnNotification = false;
    isMale = true.obs;
    // day = DateTime.now();
    avatarList = <dynamic>[
      'assets/images/0.png',
      'assets/images/1.png',
      'assets/images/2.png',
    ].obs;
    interestList = [];
    int initialPage = avatarList.length ~/ 2;
    selectedProfileindex = initialPage;
    super.onInit();
  }

  final imagePicker = ImagePicker();
  void pickImageForDashbard(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      customImage = File(pickedImage.path);
      ///// for isart the custom image iside avatar list on selected position
      int initialPage = avatarList.length ~/ 2;

      avatarList.insert(initialPage, customImage);

      Get.back();
    }
  }

  Future<bool> requestNotificationPermission() async {
    //  return await PermissionService().requestNotificationPermission();
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      // Request permission
      await Permission.notification.request();
    }
    if (status.isGranted) {
      StepsPageController stepsPageController = Get.find();

      stepsPageController.pageIdex.value = 4;
      return true;
    } else {
      return false;
    }
  }
}
