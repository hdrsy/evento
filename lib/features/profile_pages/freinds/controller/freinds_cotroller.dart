import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/profile_pages/freinds/model/freinds_model.dart';
import 'package:evento/features/profile_pages/freinds/model/recive_model.dart';
import 'package:evento/features/profile_pages/freinds/model/send_request.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class FreindsController extends GetxController {
  late RxList<FreindsModel> myFreinds;
  late RxList<ReceiveRequest> recivedFreinds;
  late RxList<SentRequest> sentFreinds;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    myFreinds = <FreindsModel>[].obs;
    recivedFreinds = <ReceiveRequest>[].obs;
    sentFreinds = <SentRequest>[].obs;
    errorMessage = <String>[].obs;
    getMyFreinds();
    getSendRequest();
    getRecivedRequest();
    super.onInit();
  }

  getMyFreinds() async {
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
      update();
      print(myFreinds.length);
    }
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
      update();
      print(recivedFreinds.length);
    }
  }

  cancelSentRequest(int userId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.denyRequest}/$userId",
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
  
  confirmRecivedRequest(int userId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.approveRequest}/$userId",
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
  deleteRecivedRequest(int userId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.denyRequest}/$userId",
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
