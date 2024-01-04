import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/profile_pages/achivment/view/widgets/achievement_card.dart';
import 'package:flutter/material.dart';

class AchievementList extends StatelessWidget {
  const AchievementList({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      
      child: Column(

        children: [
          const AchievementCard(title: "title", offerReason: "offerReason", couponInfo: "couponInfo", hwoMany: 3, hwoManyIsDone: 1),
          const AchievementCard(title: "title", offerReason: "offerReason", couponInfo: "couponInfo", hwoMany: 4, hwoManyIsDone: 3),
          const AchievementCard(title: "title", offerReason: "offerReason", couponInfo: "couponInfo", hwoMany: 2, hwoManyIsDone: 1),
          const AchievementCard(title: "title", offerReason: "offerReason", couponInfo: "couponInfo", hwoMany: 1, hwoManyIsDone: 1),
          ].divide(const SizedBox(height: 10,)),
      ),
    );
  }
}