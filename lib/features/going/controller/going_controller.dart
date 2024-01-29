import 'package:dartz/dartz.dart';
import '../../../core/server/helper_api.dart';
import '../../../core/server/server_config.dart';
import '../../../core/shared/controllers/pagination_controller.dart';
import '../../../core/utils/error_handling/erroe_handling.dart';
import '../model/going_model.dart';
import '../../profile_pages/profile/controller/profile_controller.dart';
import '../../../main.dart';
import 'package:get/get.dart';

class GoingController extends PaginationController<GoingModel> {
  GoingController()
      : super(fetchDataCallback: _fetchData, cacheKey: "GoingController");
  static int? eventId;
  @override
  void onInit() {
    super.onInit();
    eventId = Get.arguments as int; // Cast to the appropriate type
    // Now you can use eventId in your fetchData or anywhere in the controller
  }

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl = "${ServerConstApis.showGoing}/$eventId?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['Goings']['data'];
    lastPageId = handlingResponse['Goings']['last_page'];

    itemList.addAll(categoryListJson
        .map((jsonItem) => GoingModel.fromJson(jsonItem))
        .toList());
    updateFriendRequestStatus(itemList);
    if (pageId == lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  void updateFriendRequestStatus(List<GoingModel> models) {
    final ProfileController profileController = Get.find();
    for (var model in models) {
      // Assuming a match is defined as having the same id
      if (model.id == profileController.profileModel.id) {
        model.friendRequestStatus = 'me';
      }
    }
  }

  onPressAddFreind(int userId, int modelId) async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.freindRequest}/$userId",
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      itemList[modelId].friendRequestStatus = 'pending';
      update();
    }
  }

  onPressCancelReques(int requestId, int modelId) async {
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
      itemList[modelId].friendRequestStatus = null;
      update();
    }
  }
}
