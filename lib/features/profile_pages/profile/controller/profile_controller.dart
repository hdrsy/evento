import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/services/user_info.dart';
import '../model/profile_model.dart';
import '../../../../main.dart';

import 'package:get/get.dart';

class ProfileController extends GetxController{
  late ProfileModel profileModel;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  
 @override
  void onInit() async{
    isLoading=false.obs;
    errorMessage=<String>[].obs;
    user = await UserInfo.getUserInfo();
    await  getProfileInfo();
    super.onInit();
  }
  
  getProfileInfo()async{
profileModel=ProfileModel.fromJson(user!.toJson());
  }
  

}