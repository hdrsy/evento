import 'package:evento/features/customize_event/serivce_according_category/model/service_according_category_model.dart';
import 'package:get/get.dart';

class ServiceAccordingDetailesController extends GetxController{
  late ServiceProvider serviceProvider;
@override
  void onInit() {
    serviceProvider=Get.arguments;
    super.onInit();
  }
}