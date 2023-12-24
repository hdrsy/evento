import 'package:evento/features/gallery/controller/gallery_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class GalleryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryController>(() =>GalleryController());
   
  }
}
