import '../map_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class MapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(() =>MapController());
   
  }
}
