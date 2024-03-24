import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/events/customize_event/venue/model/venue_model.dart';
import 'package:evento/features/profile_pages/notification/model/notification_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class VenueDetailesForUserController extends GetxController {
  late RxBool isLoading;
  RxBool isError = false.obs;
  late Venue venue;
  late RxList<String> errorMessage;
  late int venueId;
  @override
  void onInit() async {
    isLoading = false.obs;

    errorMessage = <String>[].obs;
    venueId = Get.arguments;
    await fetchCategoryData();
    isThereNotification.value = false;
    super.onInit();
  }

  fetchCategoryData() async {
    try {
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: "${ServerConstApis.getVenueDetailes}/$venueId",
          method: "GEt",
          token: token);
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        isError.value = true;
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        whenGetDataSuccess(handlingResponse);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }
  }

  whenGetDataSuccess(handlingResponse) {
    print(handlingResponse);
    // List<dynamic> categoryListJson = handlingResponse['Notification'];

    // var reversedList = categoryListJson
    //     .map((jsonItem) => NotificationModel.fromJson(jsonItem))
    //     .toList()
    //     .reversed
    //     .toList();
    venue = Venue.fromJson(handlingResponse['venue']);
    // notificationList.addAll(reversedList);

    isLoading.value = false;
  }
}
