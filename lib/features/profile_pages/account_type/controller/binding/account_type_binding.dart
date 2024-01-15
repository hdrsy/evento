import '../account_type_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class AccountTypeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountTypeController>(() =>AccountTypeController());
   
  }
}
