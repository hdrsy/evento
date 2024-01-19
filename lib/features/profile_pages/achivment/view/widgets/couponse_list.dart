import 'package:evento/features/profile_pages/achivment/controller/achivment_controller.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/helper/flutter_flow_util.dart';
import 'coupon_card.dart';
import 'package:flutter/material.dart';

class CouponseList extends StatelessWidget {
   CouponseList({super.key});
final AchivmentController achivmentController=Get.find();
  @override
  Widget build(BuildContext context) {
    return  Obx(
      ()=> SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: 
        
         Column(
    
          children: [
           ...List.generate(achivmentController.notificationList.length, (index) =>CouponCard(promoCode:  achivmentController.notificationList[index],))
           ].divide(const SizedBox(height: 10,)),
        ),
      ),
    );
  }
}