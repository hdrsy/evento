import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/controllers/pagination_controller.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/main.dart';
import '../model/venue_model.dart';
import 'package:get/get.dart';

class VenueController extends PaginationController<Venue> {
  VenueController()
      : super(fetchDataCallback: _fetchData, cacheKey: "VenueController");
  late bool isInCustomuzEvent;
  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl = "${ServerConstApis.getAllvenue}?page=$page";
    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    isInCustomuzEvent = Get.arguments;

    List<dynamic> categoryListJson = handlingResponse['message']['data'];
    lastPageId = handlingResponse['message']['last_page'];
    itemList.addAll(
        categoryListJson.map((jsonItem) => Venue.fromJson(jsonItem)).toList());

    print("length of data ${itemList[3].venueAlbums.length}");
    if (pageId == lastPageId) {
      hasMoreData.value = false;
    }
    print("page id :$pageId");
    print("last page id :$lastPageId");
    pageId++;
    isLoading.value = false;
    isLoadingMoreData.value = false;
  }
}
