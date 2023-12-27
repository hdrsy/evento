
import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/controllers/pagination_controller.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/going/model/going_model.dart';
import 'package:evento/main.dart';

class GoingController extends PaginationController<GoingModel> {
  GoingController() : super(fetchDataCallback: _fetchData);

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token") ?? "";
    String apiUrl = "${ServerConstApis.showGoing}/$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    print(handlingResponse);
    List<dynamic> categoryListJson = handlingResponse['Goings']['data'];
    lastPageId = handlingResponse['Goings']['last_page'];

    itemList.addAll(categoryListJson
        .map((jsonItem) => GoingModel.fromJson(jsonItem))
        .toList());
    if (pageId == lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }

  
}
