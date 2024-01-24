import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/my_request_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class MyRequestController extends GetxController {
  late List<MyRequestModel> myRequestsList;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  @override
  void onInit() {
    myRequestsList = [];
    errorMessage = <String>[].obs;
    isLoading=false.obs;
    getMyEventRequests();
    super.onInit();
  }

  getMyEventRequests() async {
    isLoading.value=true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myEventRequest,
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['data'];

      myRequestsList = interestsJson
          .map((jsonItem) => MyRequestModel.fromJson(jsonItem))
          .toList();
    isLoading.value=false;
      update();
    }
  }
}
