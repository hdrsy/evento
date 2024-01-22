import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/profile_pages/notification/model/notification_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';


class NotificationController extends GetxController {
  late RxBool isLoading;
  late RxList<NotificationModel> notificationList;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    isLoading = false.obs;
    notificationList = <NotificationModel>[  //// the tonight and this week is fixed in the list becuase this always exist
    ].obs;
    errorMessage = <String>[].obs;
    fetchCategoryData();
    super.onInit();
  }

  fetchCategoryData() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout:ServerConstApis.getNotification,
        method: "GEt",
        token: token);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    print(handlingResponse);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();


      
          } else {
      whenGetDataSuccess(handlingResponse);
    }
    isLoading.value = false;
  }

  whenGetDataSuccess(handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['Notification'];

    notificationList.addAll(
        categoryListJson.map((jsonItem) => NotificationModel.fromJson(jsonItem)));
    isLoading.value = false;
  }
}
