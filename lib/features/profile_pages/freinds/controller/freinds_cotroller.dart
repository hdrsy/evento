import 'dart:developer';

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
  late RxBool isMyFriendsLoading;
  late RxBool isSentFreindsLoading;
  late RxBool isRecivedFreindsLoading;
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
    isMyFriendsLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myFreinds, method: "GEt", token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['friends'];

      myFreinds.value = interestsJson
          .map((jsonItem) => FreindsModel.fromJson(jsonItem))
          .toList();
      print(myFreinds.length);
    }
    update();
    isMyFriendsLoading.value = false;
  }

  getSendRequest() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.mySentRequests,
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['Sent_request'];

      sentFreinds.value = interestsJson
          .map((jsonItem) => SentRequest.fromJson(jsonItem))
          .toList();
      update();
      print(sentFreinds.length);
    }
  }

  getRecivedRequest() async {
    // isRecivedFreindsLoading.value=true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myReciviedRequests,
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['receive_request'];

      recivedFreinds.value = interestsJson
          .map((jsonItem) => ReceiveRequest.fromJson(jsonItem))
          .toList();
      print(recivedFreinds.length);
      update();
    }
    // isRecivedFreindsLoading.value=false;
  }

  cancelSentRequest(int requestId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
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
    String token = await prefService.readString("token") ?? "";
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

      Get.offAndToNamed('/FreindsScreen');
    }
  }

  confirmRecivedRequest(int senderId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.approveRequest}/$senderId",
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

  deleteRecivedRequest(int senderId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
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
