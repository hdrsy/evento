import 'package:evento/features/profile_pages/account_type/controller/account_type_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class AccountTypeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountTypeController>(() =>AccountTypeController());
   
  }
}
