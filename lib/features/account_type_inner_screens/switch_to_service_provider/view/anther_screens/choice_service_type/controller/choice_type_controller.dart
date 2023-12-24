import 'package:get/get.dart';

class ChoiceTypeController extends GetxController{
  late List<ChoiceServiceTypeModel> choiceServiceList;
  String sericeSelected='';
 @override
  void onInit() {
    choiceServiceList=[
ChoiceServiceTypeModel(name: "Venue", ),
ChoiceServiceTypeModel(name: "Photographer", ),
ChoiceServiceTypeModel(name: "Dress Shop", ),
ChoiceServiceTypeModel(name: "Decoration", ),
ChoiceServiceTypeModel(name: "Flower", ),
ChoiceServiceTypeModel(name: "Musician", ),
ChoiceServiceTypeModel(name: "Band", ),
ChoiceServiceTypeModel(name: "DJ", ),
ChoiceServiceTypeModel(name: "Lighting", ),
    ];
    super.onInit();
  }
  changeSelectedService(String value){
    sericeSelected=value;
    update();
  }
  
}

class  ChoiceServiceTypeModel{
  final String name;
  
  

  ChoiceServiceTypeModel({required this.name, });

}