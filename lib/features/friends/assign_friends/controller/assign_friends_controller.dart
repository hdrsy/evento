import 'package:evento/features/booking/book_now/controller/book_now_controller.dart';
import 'package:evento/features/friends/freinds/model/freinds_model.dart';
import 'package:get/get.dart';

class AssignFriendsController extends GetxController {
  late List<FreindsModel> myFreinds;
  late int ticketIndex;
  @override
  void onInit() {
    myFreinds = Get.arguments[0];
    ticketIndex = Get.arguments[1];
    super.onInit();
  }

  onPressFillFriendData(int freindIndex) {
    final BookNowController bookNowController = Get.find();
    bookNowController.ticketList[ticketIndex].fisrtName.text =
        myFreinds[freindIndex].firstName;
    bookNowController.ticketList[ticketIndex].lastName.text =
        myFreinds[freindIndex].lastName;
    //  bookNowController. ticketList[ticketIndex].phoneNumber.text = myFreinds[freindIndex] .phoneNumber;
    //  bookNowController. ticketList[ticketIndex].age.text =
    //       calculateAge(DateTime.parse(user!.birthDate)).toString();
    Get.back();
    Get.back();
  }
}
