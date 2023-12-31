import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/customize_event/type_to_set_event/controller/type_to_set_event_controller.dart';
import 'package:evento/features/customize_event/type_to_set_event/view/widgets/customize_event_button.dart';
import 'package:evento/features/customize_event/type_to_set_event/view/widgets/event_types_widget.dart';
import 'package:evento/features/customize_event/type_to_set_event/view/widgets/slider.dart';
import 'package:evento/features/customize_event/type_to_set_event/view/widgets/step_text.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypeToSetEventScreen extends StatelessWidget {
   TypeToSetEventScreen({super.key});
final TypetoSetEventController typetoSetEventController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: customColors.secondaryBackground,
     appBar:  AppBar(
      backgroundColor: customColors.secondaryBackground,
        title:Text( "Customize Event",style: customTextStyle.bodyMedium.copyWith(
          color: customColors.primary,
          fontSize: 20
        )),
        centerTitle: true,
      ),
      body:Obx(
()=> typetoSetEventController.isLoading.value?SizedBox():
 Container(
  padding: padding(16, 16,16, 16),
          
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const StepText(),
              const LinearPercentIndicatorWidget(),
               EventTypesWidget(),
              SizedBox(height: scaleHeight(15),),
              
              const CustomizeEventButton()
              
            ].divide(SizedBox(height: scaleHeight(10),))
            ),
        ),
      )
      );
  }
}