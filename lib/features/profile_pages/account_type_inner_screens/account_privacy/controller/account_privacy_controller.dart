import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/profile_pages/profile/controller/profile_controller.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class AccountPrivacyController extends GetxController {
  late RxBool isAccountPrivate;
  @override
  void onInit() {
    
    ProfileController profileController=Get.find();
    profileController.profileModel.type=="normal"?isAccountPrivate = false.obs:isAccountPrivate = true.obs;
    super.onInit();
  }

  changeAccoutPrivacy() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    
    Map<String,String> data=isAccountPrivate.value?{'type': "noraml"}:{'type': "priavate"};
    
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.updateProfile,
        method: "post",
        data: data,
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
    } else {
      isAccountPrivate.value = !isAccountPrivate.value;
      Get.offAllNamed('/home');
    }
  }
}
