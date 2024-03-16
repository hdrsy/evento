import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/services/pushy.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class LogOutController extends GetxController {
  late RxBool isLoading;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    super.onInit();
  }

  onClickSignIn() async {
    isLoading.value = true;
    // final fcmToken = await firebaseMessaging.getToken();
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    String deviceToken = await pushyRegister();

    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.logout,
        method: "post",
        data: {"device_token": deviceToken},
        token: token);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);

    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      whenSignInSuccess(handlingResponse);
    }

    isLoading.value = false;
  }

  whenSignInSuccess(handlingResponse) async {
    Get.offAllNamed('/');
    prefService.remove('token');
    prefService.remove('userInfo');
    prefService.remove('isCompleteProfile');
  }
}
