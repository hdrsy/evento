import 'package:evento/core/shared/widgets/guest/guest_popup.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/text_fields/search_filed.dart';
import '../../../../main_bottom_navigation_bar/controller/main_bottom_navigation_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAndNotification extends StatelessWidget {
  const SearchAndNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding(0,10,5,0),
      height: scaleHeight(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
Expanded(child: searchTextField(onChanged: (value){},onTap: (){
  final MainBottomNavigationController mainBottomNavigationController=Get.find();
  mainBottomNavigationController.changePage(1);
}),),
SizedBox(width: scaleWidth(20),),
InkWell(
  onTap: () {
     if(isGuset){
                    Get.dialog( GuestPopupWidget());
                  }else{
    Get.toNamed('/NotificationScreen');}
  },
  child:   Icon(
  
    Icons.notifications_none_outlined,
  
    color: customColors.secondaryText,
  
    size: 30,
  
  ),
)

        ],
      ),
    );
  }
}