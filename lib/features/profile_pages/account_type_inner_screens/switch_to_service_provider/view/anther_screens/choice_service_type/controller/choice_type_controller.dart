import 'package:dartz/dartz.dart';
import '../../../../../../../../core/server/helper_api.dart';
import '../../../../../../../../core/server/server_config.dart';
import '../../../../../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../../../../customize_event/service_category/model/service_category_model.dart';
import '../../../../../../../../main.dart';
import 'package:get/get.dart';

class ChoiceTypeController extends GetxController {
  late RxList<String> errorMessage;
  late RxList<ServiceCategoryModel> serviceCategoryList;
  late RxList<int> selectedCategories;
  late RxBool isLoading;
  @override
  void onInit() async {
    errorMessage = <String>[].obs;
    selectedCategories = <int>[].obs;
    isLoading = false.obs;
    serviceCategoryList = <ServiceCategoryModel>[].obs;
    await fetchCategoryData();

    super.onInit();
  }

  changeSelectedService(int categoryId) {
    selectedCategories.contains(categoryId)
        ? selectedCategories.remove(categoryId)
        : selectedCategories.add(categoryId);
    update();
  }

  fetchCategoryData() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.serviceCategory,
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      whenGetDataSuccess(handlingResponse);
    }
    isLoading.value = false;
  }

  whenGetDataSuccess(handlingResponse) {
    List<dynamic> categoryListJson = handlingResponse['category'];

    serviceCategoryList.addAll(categoryListJson
        .map((jsonItem) => ServiceCategoryModel.fromJson(jsonItem)));
    // isLoading.value = false;
  }
}

class ChoiceServiceTypeModel {
  final String name;

  ChoiceServiceTypeModel({
    required this.name,
  });
}
