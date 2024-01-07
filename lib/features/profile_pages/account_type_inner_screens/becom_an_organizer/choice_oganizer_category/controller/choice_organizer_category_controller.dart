import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/model/category_model.dart';
import 'package:get/get.dart';

class ChoiceOrganizerCategoryController extends GetxController{
  late List<ChoiceOrganizerCategoryTypeModel> choiceServiceList;
  String sericeSelected='';
  late RxList<int> selectedCategories;
 @override
  void onInit() {
    choiceServiceList=[
    ];
    selectedCategories=<int>[].obs;
    getCategoriesList();
    super.onInit();
  }
  changeSelectedService(int categoryId){
    selectedCategories.contains(categoryId)?selectedCategories.remove(categoryId):selectedCategories.add(categoryId);
    update();
  }
  getCategoriesList(){
    final CategoryListController categoryListController=Get.find();
    List<CategoryModel> categories=[];
    categories.assignAll(categoryListController.categoryList) 
    ;
    categories.removeAt(0);
    categories.removeAt(0);
     categories.forEach((element) {
      choiceServiceList.add(ChoiceOrganizerCategoryTypeModel(name: element.title,categoryId: element.id));
     });
  }
}

class  ChoiceOrganizerCategoryTypeModel{
  final String name;
  final int categoryId;
  
  

  ChoiceOrganizerCategoryTypeModel( {required this.name,required this.categoryId });

}
