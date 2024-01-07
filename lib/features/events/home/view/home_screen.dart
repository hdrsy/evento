import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/view/widgets/category_list.dart';
import 'package:evento/features/events/home/view/widgets/featured_list.dart';
import 'package:evento/features/events/home/view/widgets/for_you.dart';
import 'package:evento/features/events/home/view/widgets/from_your_city.dart';
import 'package:evento/features/events/home/view/widgets/offers.dart';
import 'package:evento/features/events/home/view/widgets/orgnizer.dart';
import 'package:evento/features/events/home/view/widgets/search_and_notification.dart';
import 'package:evento/features/events/home/view/widgets/trending_now.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
final HomeController homeController=Get.find();
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
      backgroundColor: customColors.secondaryBackground,
        title:Text( "Home Page",style: customTextStyle.bodyMedium.copyWith(
          color: customColors.primary,
          fontSize: screenSize == ScreenSize.small
        ? 18
        : (screenSize == ScreenSize.medium ? 20 : 22)
        )),
        centerTitle: true,
      ),
      body:
      
       RefreshIndicator(
        onRefresh:(){
        return  homeController.onrefresh();
        },
        child: buildBody()), 
      
    );
  }
  Widget buildBody(){
    return SingleChildScrollView(
      padding: padding(10,15,10,15),
      child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         CategoryList(),
        const SearchAndNotification(),
         FeaturedList(),
        TrendingNow(),
         FromYourCity(),
        // const Offers(),
         Orgnizers(),
         ForYou()
      ].divide( SizedBox(height:  screenSize == ScreenSize.small
        ? 20
        : (screenSize == ScreenSize.medium ? 22 : 24),)),
      ),
    );
  }
}