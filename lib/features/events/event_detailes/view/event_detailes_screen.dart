import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/features/events/event_detailes/view/widgets/information_event.dart';
import 'package:evento/features/events/event_detailes/view/widgets/main_image.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailesScreen extends StatelessWidget {
   EventDetailesScreen({super.key});
final EventDetailesController eventDetailesController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: customColors.primaryBackground,
      body: Obx(()=>eventDetailesController.isLoading.value? Center(child: CircularProgressIndicator(color: customColors.secondaryText,),):_buildBody()),
    );
  }
  Widget _buildBody(){
    return  Stack(
      alignment: Alignment.center,
      children: [
        MainImage(imgUrl: "/storage/${eventDetailesController.eventDetailsModel.images[0]}"),
        Positioned(
          // alignment: AlignmentDirectional(0,1),
          top: screenHeight*0.32,
          child: InformationEvent(eventDetailsModel:eventDetailesController.eventDetailsModel)),
          
      ],
    );

  }
}