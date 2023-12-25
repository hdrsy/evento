import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/customize_event/serivce_according_category/model/service_according_category_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class ServiceAccordingCategoryController extends GetxController{
  late RxList<ServiceProvider> serviceProviderList;
  late int serviceAccordingCategoryIndex;
  late RxBool isLoading;
late String serviceCategoryType;
  late RxList<String> errorMessage;
@override
  void onInit() async{
         isLoading = false.obs;
       errorMessage = <String>[].obs;
       serviceProviderList=<ServiceProvider>[].obs;
    serviceAccordingCategoryIndex=Get.arguments[0];
    serviceCategoryType=Get.arguments[1];
  await  fetchData();
    super.onInit();
  }
  fetchData()async{

  isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.serviceAccordingCategory}/$serviceAccordingCategoryIndex",
        method: "GEt",
        token: token);
    print(response);  
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();


    } else {
      whenGetDataSuccess(handlingResponse);
    }
    isLoading.value = false;
  }

  whenGetDataSuccess(handlingResponse) {
    
    List<dynamic> categoryListJson = handlingResponse['service_provider'];

    serviceProviderList.addAll(
        categoryListJson.map((jsonItem) => ServiceProvider.fromJson(jsonItem)));
// log(serviceCategoryList.length.toString());
    // isLoading.value = false;
  }
}