import '../../../../core/responsive/responsive.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/type_to_set_event_controller.dart';
import 'widgets/customize_event_button.dart';
import 'widgets/event_types_widget.dart';
import 'widgets/slider.dart';
import 'widgets/step_text.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class TypeToSetEventScreen extends StatelessWidget {
   TypeToSetEventScreen({super.key});
final TypetoSetEventController typetoSetEventController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: customColors.secondaryBackground,
     appBar:  AppBar(
      backgroundColor: customColors.secondaryBackground,
        title:Text(tr( "Customize Event"),style: customTextStyle.bodyMedium.copyWith(
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