import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/controllers/pagination_controller.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/profile_pages/notification/model/notification_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class NotificationController extends PaginationController<NotificationModel> {
  NotificationController()
      : super(fetchDataCallback: _fetchData, cacheKey: "notifications");

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl = "${ServerConstApis.getNotification}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['Notification']['data'];
    lastPageId = handlingResponse['Notification']['last_page'];

    var reversedList = categoryListJson
        .map((jsonItem) => NotificationModel.fromJson(jsonItem))
        .toList();

    itemList.addAll(reversedList);

    if (pageId == lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoadingMoreData.value = false;
    isThereNotification.value = false;
  }
}
