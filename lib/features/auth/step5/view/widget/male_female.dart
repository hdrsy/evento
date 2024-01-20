// Function to build the main Stack widget
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/features/auth/steps/controller/steps_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildMainStack(BuildContext context) {
  StepsController stepsController=Get.find();
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 10, 6),
    child: Obx(
  ()    => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container for the first item (Male)
          _buildItemContainer(context,tr( 'Male'),stepsController.isMale.value? customColors.primary:Colors.white,stepsController.isMale.value?  Colors.white:customColors.primary),
          // // Container for the second item (Female)
          _buildItemContainer(context, tr('Female'), stepsController.isMale.value? Colors.white:customColors.primary,stepsController.isMale.value?  customColors.primary:Colors.white),
        ],
      ),
    ),
  );
}

// Function to build the item container
Widget _buildItemContainer(BuildContext context, String localizationKey, Color backgroundColor, Color textColor) {

  return GestureDetector(
    onTap: (){
      StepsController stepsController=Get.find();
stepsController.isMale.value=localizationKey=="Male";

    },
    child: Stack(
      alignment:localizationKey=="Female"? const AlignmentDirectional(-1,0):const AlignmentDirectional(1,0),
      children: [
        Container(
            width: scaleWidth(156),
            height: scaleHeight(216),
            decoration: BoxDecoration(
              color:backgroundColor,
              boxShadow:const [
                 BoxShadow(
                  blurRadius: 24,
                  color: Color(0x0D000000),
                  offset: Offset(0, 0),
                )
              ],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment:localizationKey=="Female"?  MainAxisAlignment.start:MainAxisAlignment.end,
                crossAxisAlignment:localizationKey=="Female"? CrossAxisAlignment.center :CrossAxisAlignment.start,
                children: [
                  
                  Align(
                    alignment: localizationKey=="Female"?const AlignmentDirectional(1,0):const AlignmentDirectional(-1,0),
                    child: Text(
                    localizationKey,
                      style: customTextStyle.bodyMedium.copyWith(
                            fontFamily: 'BeerSerif',
                            color:textColor,
                            fontWeight: FontWeight.w500,
                            
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
     Image.asset(
      localizationKey=="Female"?  'assets/images/Group_17613_(1).png':  'assets/images/character-1_(1).png',
        width: scaleWidth(150),
      height: scaleHeight(200),
      fit: BoxFit.cover,
      alignment: const Alignment(0.00, -1.00),
      ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimationmalefemale']!), // Animation on page load
   
    
      ],
    ),
    
  );
}
