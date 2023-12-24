import 'package:evento/features/events/see_all/controller/see_all_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class SeeAllBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeeAllController>(() =>SeeAllController());
  }
}
