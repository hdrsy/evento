import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/profile_pages/my_booking/controller/my_booking_controller.dart';
import 'package:evento/features/profile_pages/my_booking/view/widget/my_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CanceledList extends StatelessWidget {
   CanceledList({super.key});
final MyBookingController myBookingController =Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(24,10,24,10),
      child: Column(
        children: [
          ...List.generate(myBookingController.cancelledBooking.length, (index) => MyBookingCard(
            isCanceldSection: true,
            bookingStatus: "Canceled",
            model: myBookingController.cancelledBooking[index].eventClass.event,
          ))
        ].divide(const SizedBox(height: 10,)),
      ),
    );
  }
}