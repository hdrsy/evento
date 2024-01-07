import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/profile_pages/my_request/model/my_request_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class MyRequestController extends GetxController {
  late List<MyRequestModel> myRequestsList;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    myRequestsList = [];
    errorMessage = <String>[].obs;
    getMyEventRequests();
    super.onInit();
  }

  getMyEventRequests() async {
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
      update();
    }
  }
}
