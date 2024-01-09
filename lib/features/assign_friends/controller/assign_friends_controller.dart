import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/features/book_now/controller/book_now_controller.dart';
import 'package:evento/features/profile_pages/freinds/model/freinds_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class AssignFriendsController extends GetxController{
  late List<FreindsModel> myFreinds;
  late int ticketIndex;
  @override
  void onInit() {
   myFreinds=Get.arguments[0];
   ticketIndex=Get.arguments[1];
    super.onInit();
  }
   onPressFillFriendData(int freindIndex) {
   final BookNowController bookNowController=Get.find();
   bookNowController. ticketList[ticketIndex].fisrtName.text =myFreinds[freindIndex] .firstName;
   bookNowController. ticketList[ticketIndex].lastName.text = myFreinds[freindIndex] .lastName;
  //  bookNowController. ticketList[ticketIndex].phoneNumber.text = myFreinds[freindIndex] .phoneNumber;
  //  bookNowController. ticketList[ticketIndex].age.text =
  //       calculateAge(DateTime.parse(user!.birthDate)).toString();
    Get.back();
    Get.back();
  }
 
}