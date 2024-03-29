import 'package:dartz/dartz.dart';
import 'package:evento/features/service_provider/show_profile_for_user.dart/model/show_profile_for_user.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class ServiceAccordingDetailesForUserController extends GetxController {
  late ServiceProvider serviceProvider;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  RxBool isError = false.obs;
  late int serviceProviderId;
// late bool isorganizerEditProfile;

  @override
  void onInit() {
    errorMessage = <String>[].obs;
    isLoading = false.obs;
    serviceProviderId = Get.arguments;
    // isorganizerEditProfile = Get.arguments[1]??false;

    getOrganizerProfile();
    super.onInit();
  }

  getOrganizerProfile() async {
    try {
      Either<ErrorResponse, Map<String, dynamic>> response;
      isLoading.value = true;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout:
              "${ServerConstApis.serviceProfileForUser}/$serviceProviderId",
          method: "GEt",
          token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        isError.value = true;
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        final interestsJson = handlingResponse['message'];
        serviceProvider = ServiceProvider.fromJson(interestsJson);
      }
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }
  }
}
