import '../../serivce_according_category/model/service_according_category_model.dart';
import 'package:get/get.dart';

class ServiceAccordingDetailesController extends GetxController {
  late ServiceProvider serviceProvider;
  late int serviceCategoryIndex;
  late bool isInCustomuzEvent;

  @override
  void onInit() {
    serviceProvider = Get.arguments[0];
    serviceCategoryIndex = Get.arguments[1];
    isInCustomuzEvent = Get.arguments[2];
    super.onInit();
  }
}
