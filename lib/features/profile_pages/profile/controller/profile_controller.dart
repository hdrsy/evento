import 'package:evento/core/utils/services/back_ground_service.dart';
import 'package:evento/core/utils/services/notification_service.dart';
import 'package:evento/core/utils/services/work_manager.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../core/utils/services/user_info.dart';
import '../model/profile_model.dart';
import '../../../../main.dart';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  late ProfileModel profileModel;
  late RxBool isLoading;
  late RxList<String> errorMessage;

  @override
  void onInit() async {
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    user = await UserInfo.getUserInfo();
    bool isCompleteProfile =
        await prefService.readString("isCompleteProfile") == "true";
    await getProfileInfo();
    if (isCompleteProfile && targetRout == '/home') {
      initializeService();
      await NotificationService().init();
      final service = FlutterBackgroundService();
      service.startService();
      service.invoke("setAsBackground");
      // listenToEvents(2);
      // initWorkManager();
      // registertask();
    }
    super.onInit();
  }

  getProfileInfo() async {
    profileModel = ProfileModel.fromJson(user!.toJson());
  }
}
