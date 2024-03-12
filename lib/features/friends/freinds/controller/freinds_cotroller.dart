import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/freinds_model.dart';
import '../model/recive_model.dart';
import '../model/send_request.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class FreindsController extends GetxController {
  late RxList<FreindsModel> myFreinds;
  late RxList<ReceiveRequest> recivedFreinds;
  late RxList<SentRequest> sentFreinds;
  late RxList<String> errorMessage;
  late RxBool isSentFreindsLoading;
  late RxBool isMyFriendsLoading;
  late RxBool isRecivedFreindsLoading;
  RxBool isSentFreindsError = false.obs;
  RxBool isMyFriendsError = false.obs;
  RxBool isRecivedFreindsError = false.obs;
  @override
  void onInit() {
    myFreinds = <FreindsModel>[].obs;
    recivedFreinds = <ReceiveRequest>[].obs;
    sentFreinds = <SentRequest>[].obs;
    errorMessage = <String>[].obs;
    isMyFriendsLoading = false.obs;
    isRecivedFreindsLoading = false.obs;
    isSentFreindsLoading = false.obs;
    getMyFreinds();
    getSendRequest();
    getRecivedRequest();
    super.onInit();
  }

  getMyFreinds() async {
    try {
      isMyFriendsLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.myFreinds, method: "GEt", token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        isMyFriendsError.value = true;
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        List<dynamic> interestsJson = handlingResponse['friends'];

        myFreinds.value = interestsJson
            .map((jsonItem) => FreindsModel.fromJson(jsonItem))
            .toList();
      }
      update();
      isMyFriendsLoading.value = false;
    } catch (e) {
      isMyFriendsLoading.value = false;
      isMyFriendsError.value = true;
    }
  }

  getSendRequest() async {
    try {
      isSentFreindsLoading.value = true;

      sentFreinds.clear();
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.mySentRequests,
          method: "GEt",
          token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        isSentFreindsError.value = true;
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        List<dynamic> interestsJson = handlingResponse['sentRequest'];

        sentFreinds.value = interestsJson
            .map((jsonItem) => SentRequest.fromJson(jsonItem))
            .toList();
        update();
      }
      isSentFreindsLoading.value = false;
    } catch (e) {
      isSentFreindsLoading.value = false;
      isSentFreindsError.value = true;
    }
  }

  getRecivedRequest() async {
    try {
      isRecivedFreindsLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.myReciviedRequests,
          method: "GEt",
          token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        isRecivedFreindsError.value = true;
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        List<dynamic> interestsJson = handlingResponse['receiveRequest'];

        recivedFreinds.value = interestsJson
            .map((jsonItem) => ReceiveRequest.fromJson(jsonItem))
            .toList();
        update();
      }
      isRecivedFreindsLoading.value = false;
    } catch (e) {
      isRecivedFreindsLoading.value = false;
      isRecivedFreindsError.value = true;
    }
    // isRecivedFreindsLoading.value=false;
  }

  cancelSentRequest(int requestId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.cancelRequest}/$requestId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      sentFreinds.removeAt(modelId);
      update();
    }
  }

  unFreindRequest(int userId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.cancelRequest}/$userId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      myFreinds.removeAt(modelId);
      update();
      Get.back();

      // If there is another bottom sheet underneath, close it as well
      // You can call Get.back() again if needed, depending on your app's flow
      Get.back();
    }
  }

  confirmRecivedRequest(int senderId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.approveRequest}/$senderId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      recivedFreinds.removeAt(modelId);
      await getMyFreinds();
      update();
    }
  }

  deleteRecivedRequest(int senderId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.denyRequest}/$senderId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      recivedFreinds.removeAt(modelId);
      update();
    }
  }
}
