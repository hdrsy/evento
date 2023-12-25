import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/profile_pages/notification/view/widget/notification_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Notifications",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NotificationCard(isReaded: false,),
            const NotificationCard(isReaded: false,),
            const NotificationCard(isReaded: true,),
            const NotificationCard(isReaded: true,),
          ].divide(
Divider(
  thickness: 1,
  color:customColors.secondary,
)
),
        ),
      ),
      );
  }
}