import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/main.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';

class AccountTypeController extends GetxController {
  RxBool isAccountPrivate = (user!.type == "private").obs;
  RxBool isLoadingDeleteAccount = false.obs;
  RxList<String> errorMessage = <String>[].obs;

  onClickSignIn() async {
    isLoadingDeleteAccount.value = true;
    // final fcmToken = await firebaseMessaging.getToken();
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");

    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.deteAccount,
        method: "delete",
        token: token);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);

    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      whenSignInSuccess(handlingResponse);
    }

    isLoadingDeleteAccount.value = false;
  }

  whenSignInSuccess(handlingResponse) async {
    Get.offAllNamed('/');
    prefService.remove('token');
    prefService.remove('userInfo');
    prefService.remove('isCompleteProfile');
    // FlutterBackgroundService service = FlutterBackgroundService();
    // service.invoke("stopService");
  }
}
