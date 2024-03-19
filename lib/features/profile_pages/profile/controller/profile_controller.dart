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
      if (isCompleteProfile && targetRout == '/home') {}
    }
    super.onInit();
  }

  getProfileInfo() async {
    profileModel = ProfileModel.fromJson(user != null ? user!.toJson() : {});
  }
}
