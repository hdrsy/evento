
import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../events/home/model/category_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class TypetoSetEventController extends GetxController{
  
    late RxBool isLoading;
  late RxList<CategoryModel> categoryList;
  late RxInt selectedCategory;
  
   late RxList<String> errorMessage;
@override
  void onInit() async{
   isLoading=false.obs;
   errorMessage = <String>[].obs;
   categoryList=<CategoryModel>[].obs;
   selectedCategory=0.obs;

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
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.getCategoryList,
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
    List<dynamic> categoryListJson = handlingResponse['category'];

    categoryList.addAll(
        categoryListJson.map((jsonItem) => CategoryModel.fromJson(jsonItem)));

    isLoading.value = false;
  }

}