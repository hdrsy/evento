import 'package:evento/features/profile_pages/my_request/model/my_request_model.dart';
import 'package:get/get.dart';

class RequestStatusController extends GetxController{
  late MyRequestModel myRequestModel;
@override
  void onInit() {
    myRequestModel=Get.arguments;
    super.onInit();
  }
}