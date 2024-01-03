import 'package:evento/features/profile_pages/add_friends/model/add_friends_model.dart';
import 'package:get/get.dart';

class AddFriendsController extends GetxController{
 late List<AddFriendsModel> addFriendsList;
  @override
  void onInit() {
    addFriendsList=[];
    super.onInit();
  }
}