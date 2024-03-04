import '../freinds_cotroller.dart';
import 'package:get/get.dart';
 // Import your controller

class FreindsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreindsController>(() =>FreindsController());
   
  }
}
