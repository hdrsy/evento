import 'package:evento/features/profile_pages/freinds/controller/freinds_cotroller.dart';
import 'package:get/get.dart';
 // Import your controller

class FreindsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreindsController>(() =>FreindsController());
   
  }
}
