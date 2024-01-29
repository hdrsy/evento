import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/interst_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class Step7Controller extends GetxController {
  late List<InterestItem> allInterestItem;
  late List<RxBool> selectedInterests;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  @override
  void onInit() {
    allInterestItem = [];
    selectedInterests = [];
    errorMessage = <String>[].obs;
    isLoading = false.obs;
    getAllInterest();
    selectedInterests =
        List.generate(allInterestItem.length, (index) => false.obs);
    super.onInit();
  }

  getAllInterest() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.getInterest, method: "GEt", token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      whenGetDataSuccess(handlingResponse);
    }
    isLoading.value = false;
  }

  whenGetDataSuccess(handlingResponse) {
    List<dynamic> interestsJson = handlingResponse['interest'];

    allInterestItem = interestsJson
        .map((jsonItem) => InterestItem.fromJson(jsonItem))
        .toList();

    selectedInterests =
        List.generate(allInterestItem.length, (index) => false.obs);

    isLoading.value = false;
  }
}
