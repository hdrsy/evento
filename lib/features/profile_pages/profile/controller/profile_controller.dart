import 'package:evento/core/utils/services/notification_service.dart';
import 'package:evento/core/utils/services/socket_servie.dart';

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
    print("user object :$user");
    bool isCompleteProfile =
        await prefService.readString("isCompleteProfile") == "true";
    print("isCompleteProfile :$isCompleteProfile");
    await getProfileInfo();
    print(targetRout);
    if (isCompleteProfile && targetRout == '/home') {
      // print("inide init service");
      // initializeService();
      await NotificationService().init();
      // SSEService.connectToSSE();
      // final service = FlutterBackgroundService();
      // service.startService();
      // service.invoke("setAsBackground");
      // SocketService.createSocketConnection();
      // connectToServer();
      // connectToWebSocket();
      listenToEvents(2);
    }
    super.onInit();
  }

  getProfileInfo() async {
    profileModel = ProfileModel.fromJson(user!.toJson());
  }
}
