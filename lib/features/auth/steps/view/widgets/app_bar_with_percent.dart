import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/features/auth/steps/controller/page_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

AppBar buildAppBarWithLineIndicatorincenter(double percent,int pageNumber) {
  return 
  AppBar(
      title: SizedBox(
        width: screenWidth,
        child: 
          LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            percent: percent,
            width: scaleWidth(120),
            lineHeight: 8,
            animation: true,
            animateFromLastPercent: true,
            progressColor: customColors.primary,
            backgroundColor: customColors.primaryBackground,
            barRadius: const Radius.circular(12),
            // padding: EdgeInsets  .zero,
          ),
        
      ),
      // centerTitle: true,
      actions: [ ifThereActionInAppBar(pageNumber)? TextButton(onPressed: (){
        // pageNumber==7?Get.toNamed('/test'):
        StepsPageController stepsPageController=Get.find();
        stepsPageController.pageIdex.value=pageNumber+1;
        
        }, child:Text("Skip",style:customTextStyle.bodyLarge)):const SizedBox(width: 24,)],
        backgroundColor: Colors.transparent,
        leading:  InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: customColors.primaryText,
            size: 24,
          ),
          onTap: () async {
StepsPageController stepsPageController=Get.find();
pageNumber>2 && stepsPageController.pageIdex.value>2?
stepsPageController.pageIdex  .value -=1:null;      

          },
        ),
        elevation: 0.0,
      );
}
 bool ifThereActionInAppBar(int pageNumber){
      switch (pageNumber) {
        case 1 ||2 ||4 ||5 ||6 ||7: return false;
          
          case 3: return true;  
        default:return false;
      }
  }