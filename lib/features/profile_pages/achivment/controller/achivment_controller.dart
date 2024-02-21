import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/profile_pages/achivment/model/coupon_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class AchivmentController extends GetxController {
  late RxBool isLoading;
  RxBool isError = false.obs;
  late RxList<PromoCode> notificationList;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    isLoading = false.obs;
    notificationList = <PromoCode>[
      //// the tonight and this week is fixed in the list becuase this always exist
    ].obs;
    errorMessage = <String>[].obs;
    fetchCategoryData();
    super.onInit();
  }

  fetchCategoryData() async {
    try {
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.myPromoCode, method: "GEt", token: token);
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
    List<dynamic> categoryListJson = handlingResponse['promoCode'];

    notificationList.addAll(
        categoryListJson.map((jsonItem) => PromoCode.fromJson(jsonItem)));
    isLoading.value = false;
  }
}
