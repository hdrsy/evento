import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/services/cache_service.dart';
import 'package:evento/core/utils/services/check_internet.dart';
import 'package:evento/features/events/home/model/category_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class TypetoSetEventController extends GetxController {
  late RxBool isLoading;
  RxBool IsErrorExist = false.obs;
  late RxList<CategoryModel> categoryList;
  late RxInt selectedCategory;
  CacheService cacheService = CacheService('customoze');
  final String cacheKey = 'customoze';
  // final ConnectivityService _connectivityService = Get.find();

  late RxList<String> errorMessage;
  @override
  void onInit() async {
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    categoryList = <CategoryModel>[].obs;
    selectedCategory = 0.obs;

    await fetchCategoryData();

    super.onInit();
  }

  // choiceCategoryItem(CategoryModel categoryModel){
  //   selectedCategory.contains(categoryModel)?selectedCategory.remove(categoryModel):selectedCategory.add(categoryModel);
  // }
  // bool isSelected(CategoryModel categoryModel){
  //  return selectedCategory.contains(categoryModel);
  // }
  fetchCategoryData() async {
    try {
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      if (await checkInternet()) {
        final d = await cacheService.getObject<Map<String, dynamic>>(
          cacheKey: cacheKey,
          deserializeFunction: (jsonMap) => jsonMap,
        );
        if (d != null) {
          whenGetDataSuccess(d);
        } else {
          isLoading.value = false;
        }
      } else {
        response = await ApiHelper.makeRequest(
            targetRout: ServerConstApis.getCategoryList,
            method: "GEt",
            token: token);
        dynamic handlingResponse = response.fold((l) => l, (r) => r);
        if (handlingResponse is ErrorResponse) {
          errorMessage.value = handlingResponse.getErrorMessages();
          IsErrorExist.value = true;
        } else {
          whenGetDataSuccess(handlingResponse);
          cacheService.cacheObject<Map<String, dynamic>>(
            object: handlingResponse,
            cacheKey: cacheKey,
            serializeFunction: (data) => data,
          );
        }
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      IsErrorExist.value = true;
    }
  }

  whenGetDataSuccess(handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['category'];

    categoryList.addAll(
        categoryListJson.map((jsonItem) => CategoryModel.fromJson(jsonItem)));

    isLoading.value = false;
  }
}
