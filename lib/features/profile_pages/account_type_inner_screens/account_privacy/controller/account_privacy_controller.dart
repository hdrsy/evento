import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/services/user_info.dart';
import 'package:evento/features/profile_pages/account_type/controller/account_type_controller.dart';
import '../../../../../core/server/helper_api.dart';
import '../../../../../core/server/server_config.dart';
import '../../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../../main.dart';
import 'package:get/get.dart';

class AccountPrivacyController extends GetxController {
  late RxBool isAccountPrivate;
  @override
  void onInit() {
    user!.type == "normal"
        ? isAccountPrivate = false.obs
        : isAccountPrivate = true.obs;
    super.onInit();
  }

  changeAccoutPrivacy() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");

    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.userChangeType,
        method: "get",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      print(handlingResponse);
    } else {
      isAccountPrivate.value = !isAccountPrivate.value;
      Get.find<AccountTypeController>().isAccountPrivate.value =
          isAccountPrivate.value;
      prefService.remove('userInfo');
      user = await UserInfo.getUserInfo();
      // Get.offAllNamed('/home');
    }
  }
}
