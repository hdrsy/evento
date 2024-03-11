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

    if (!isGuset) {
      user = await UserInfo.getUserInfo();
      bool isCompleteProfile =
          await prefService.readString("isCompleteProfile") == "true";
      await getProfileInfo();
      if (isCompleteProfile && targetRout == '/home') {
        // listenToEvents(user!.id);
        // Workmanager().registerPeriodicTask(
        //     "t", // Unique task name for fetching notifications
        //     "t",
        //     frequency: Duration(minutes: 15));
        // initializeService();
        // final service = FlutterBackgroundService();
        // service.startService();
        // service.invoke("setAsBackground");
        // listenToEvents(2);
        // initWorkManager();
        // registertask();
      }
    }
    super.onInit();
  }

  getProfileInfo() async {
    print("the user info is:${user!.image}");
    profileModel = ProfileModel.fromJson(user != null ? user!.toJson() : {});
    print("the user is :${profileModel.image}");
  }
}
