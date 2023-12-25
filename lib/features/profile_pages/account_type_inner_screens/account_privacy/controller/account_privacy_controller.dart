import 'package:get/get.dart';

class AccountPrivacyController extends GetxController{
  late RxBool isAccountPrivate;
  @override
  void onInit() {
    isAccountPrivate=false.obs;
    super.onInit();
  }
  changeAccoutPrivacy(){
    isAccountPrivate.value=!isAccountPrivate.value;
  }
}