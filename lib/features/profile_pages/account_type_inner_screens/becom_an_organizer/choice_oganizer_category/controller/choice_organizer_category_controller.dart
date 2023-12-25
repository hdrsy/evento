import 'package:get/get.dart';

class ChoiceOrganizerCategoryController extends GetxController{
  late List<ChoiceOrganizerCategoryTypeModel> choiceServiceList;
  String sericeSelected='';
 @override
  void onInit() {
    choiceServiceList=[
ChoiceOrganizerCategoryTypeModel(name: "Culture", ),
ChoiceOrganizerCategoryTypeModel(name: "Race", ),
ChoiceOrganizerCategoryTypeModel(name: "Travel", ),
ChoiceOrganizerCategoryTypeModel(name: "Tour", ),
ChoiceOrganizerCategoryTypeModel(name: "Party", ),
ChoiceOrganizerCategoryTypeModel(name: "Kids", ),
ChoiceOrganizerCategoryTypeModel(name: "Camping", ),
ChoiceOrganizerCategoryTypeModel(name: "Art", ),
ChoiceOrganizerCategoryTypeModel(name: "Theatre", ),
ChoiceOrganizerCategoryTypeModel(name: "Game", ),
    ];
    super.onInit();
  }
  changeSelectedService(String value){
    sericeSelected=value;
    update();
  }
  
}

class  ChoiceOrganizerCategoryTypeModel{
  final String name;
  
  

  ChoiceOrganizerCategoryTypeModel({required this.name, });

}
