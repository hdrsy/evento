import 'package:evento/features/auth/signin/controller/signin_controller.dart';
import 'package:evento/features/auth/signup/controller/signup_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<SigninController>(() => SigninController());
  }
}
