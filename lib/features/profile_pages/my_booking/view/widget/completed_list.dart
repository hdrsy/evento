import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/profile_pages/my_booking/controller/my_booking_controller.dart';
import 'package:evento/features/profile_pages/my_booking/view/widget/my_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedList extends StatelessWidget {
   CompletedList({super.key});
final MyBookingController myBookingController =Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding(10,24,10,24),
      child: Column(
        children: [
          ...List.generate(myBookingController.completedBooking.length, (index) =>MyBookingCard(  model: myBookingController.completedBooking[index].bookings[0].eventClass.event,
         
            isCanceldSection: false,
            leftButtonOnTap: (){},
            leftButtonTitle:"Leave a Review" ,
            bookingStatus: "Completed",
          ))
        ].divide(const SizedBox(height: 10,)),
      ),
    );
  }
}