import 'package:dartz/dartz.dart';
import 'package:evento/features/service_provider/show_profile_for_user.dart/model/show_profile_for_user.dart';
import '../../../../core/server/follow_unfollow_event_api.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class ServiceAccordingDetailesForUserController extends GetxController {
  late ServiceProvider serviceProvider;
  late RxList<String> errorMessage;
late RxBool isLoading;
late int serviceProviderId;
// late bool isorganizerEditProfile;
  
  @override
  void onInit() {
    errorMessage = <String>[].obs;
    isLoading=false.obs;
    serviceProviderId=Get.arguments;
      // isorganizerEditProfile = Get.arguments[1]??false;
  
    getOrganizerProfile();
    // TODO: implement onInit
    super.onInit();
  }

  getOrganizerProfile() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    isLoading.value=true;
    String token = await prefService.readString("token") ;
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.serviceProfileForUser}/$serviceProviderId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    print(handlingResponse);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      final interestsJson = handlingResponse['message'];
print(interestsJson); 
      serviceProvider = ServiceProvider.fromJson(interestsJson);
      
    }
    isLoading.value=false;
    update();
  }
  
 
}
