import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/features/profile_pages/notification/controller/notification_controller.dart';

import '../../../../core/utils/helper/flutter_flow_util.dart';
import 'widget/notification_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController notificationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Notifications"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: Obx(
        ()=> 
         notificationController.isLoading.value?Center(child: CircularProgressIndicator(color: customColors.primary,),):
            notificationController.notificationList.isEmpty?const EmptyData(icon:Icons.notifications_sharp ,message:"All caught up! No new notifications right now." ,):
            
        
        
        SingleChildScrollView(
          
          child: 
          
          Column(
            children: [
              ...List.generate(
                  notificationController.notificationList.length,
                  (index) => NotificationCard(
                        notificationModel:
                            notificationController.notificationList[index],
                      ))
            ].divide(Divider(
              thickness: 1,
              color: customColors.secondary,
            )),
          ),
        ),
      ),
    );
  }
}
