import 'package:evento/features/profile_pages/invite_friends/controller/invite_friends_controller.dart';
import 'package:get/get.dart';
 // Import your controller

class InviteFriendsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InviteFriendsController>(() =>InviteFriendsController());
   
  }
}
