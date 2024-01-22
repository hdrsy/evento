import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/services/back_ground_service.dart';
import 'package:evento/core/utils/services/notification_service.dart';
import 'package:evento/core/utils/services/pusher.dart';
import 'package:evento/core/utils/services/sse_serive.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
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
       bool isCompleteProfile =
      await prefService.readString("isCompleteProfile") == "true";
 
    if (isCompleteProfile && targetRout == '/home') {
    // while(user==null){
    //   log("inside while");
    // }
    initializeService();
// SSEService.connectToSSE();  
    await NotificationService().init();
    FlutterBackgroundService service=FlutterBackgroundService();
    service.startService();
  }
    await  getProfileInfo();
    super.onInit();
  }
  
  getProfileInfo()async{
profileModel=ProfileModel.fromJson(user!.toJson());
  }
  

}