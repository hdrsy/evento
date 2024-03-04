import '../favorite_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() =>FavoriteController());
   
  }
}
