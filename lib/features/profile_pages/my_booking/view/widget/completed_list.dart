import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/main.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../controller/my_booking_controller.dart';
import 'my_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class CompletedList extends StatelessWidget {
   CompletedList({super.key});
final MyBookingController myBookingController =Get.find();

  @override
  Widget build(BuildContext context) {
    return  Obx(() => 
     myBookingController.isLoading.value?Center(child: CircularProgressIndicator(color: customColors.primary,),):
            myBookingController.upComingBooking.isEmpty?const EmptyData(icon:Icons.calendar_today ,message:"No completed bookings! Explore events to find your next great experience." ,):
       
     SingleChildScrollView(
      padding: padding(10,24,10,24),
      child: Column(
        children: [
          ...List.generate(myBookingController.completedBooking.length, (index) =>MyBookingCard(  model: myBookingController.completedBooking[index].bookings[0].eventClass.event,
         
            isCanceldSection: false,
            leftButtonOnTap: (){},
            leftButtonTitle:tr("Leave a Review") ,
            bookingStatus:tr( "Completed"),
          ))
        ].divide(const SizedBox(height: 10,)),
      ),
    ));
  }
}