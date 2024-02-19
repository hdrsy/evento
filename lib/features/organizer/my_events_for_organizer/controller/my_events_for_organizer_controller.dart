import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:evento/core/shared/controllers/pagination_controller.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/my_events_for_organizer_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class MyEventsForOrganizerController
    extends PaginationController<OrganizationEvent> {
  MyEventsForOrganizerController()
      : super(fetchDataCallback: _fetchData, cacheKey: "OrganizationEvent");

  // Updated _fetchData to match the new signature
  static Future<Either<ErrorResponse, Map<String, dynamic>>> _fetchData(
      String url, int page, Map<String, dynamic> additionalParams) async {
    String token = await prefService.readString("token");
    String apiUrl = "${ServerConstApis.organizationMyEvents}?page=$page";

    // Returning the result of the API call
    return ApiHelper.makeRequest(
      targetRout: apiUrl,
      method: "GET",
      token: token,
    );
  }

  @override
  handleDataSuccess(dynamic handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['events']['data'];
    lastPageId = handlingResponse['events']['last_page'];
    dataLimit = handlingResponse['events']['per_page'];
    print("categoryListJson:$categoryListJson");
    itemList.addAll(categoryListJson
        .map((jsonItem) => OrganizationEvent.fromJson(jsonItem))
        .toList());

    if (pageId == lastPageId) {
      hasMoreData.value = false;
    }
    pageId++;
    isLoading.value = false;
    isLoadingMoreData.value = false;
    update();
  }
}