import 'package:evento/features/notification/controller/notification_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() =>NotificationController());
   
  }
}
