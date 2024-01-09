import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/services/user_info.dart';
import 'package:evento/features/profile_pages/profile/model/profile_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  late ProfileModel profileModel;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  
 @override
  void onInit() async{
    isLoading=false.obs;
    errorMessage=<String>[].obs;
    await  getProfileInfo();
    super.onInit();
  }
  
  getProfileInfo()async{
profileModel=ProfileModel.fromJson(user!.toJson());
  }
  

}