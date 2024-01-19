
import 'package:evento/core/shared/widgets/guest/error_in_guest.dart';
import 'package:evento/core/shared/widgets/guest/guest_page.dart';
import 'package:evento/core/utils/services/notification_service.dart';
import 'package:evento/core/utils/services/pusher.dart';

import '../../../core/utils/services/user_info.dart';
import '../../customize_event/type_to_set_event/view/type_to_set_event_screen.dart';
import '../../events/home/view/home_screen.dart';
import '../../profile_pages/profile/view/profile_screen.dart';
import '../../reels/view/reels_screen.dart';
import '../../search/view/search_screen.dart';
import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavigationController extends GetxController {
   List<Widget> screens= [
      HomeScreen(),
       SearchScreen(),
      ReelsScreen(),
     isGuset?const GuestWidget():  TypeToSetEventScreen(),
       isGuset?const GuestWidget():ProfileScreen()
    ];
   
  @override
  void onInit() async{
  
   
    super.onInit();
  }

  RxInt selectedPage = 0.obs;
  changePage(int index) {
    selectedPage.value = index;
  }
}
