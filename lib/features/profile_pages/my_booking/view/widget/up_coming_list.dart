import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/cancale_booking.dart';
import 'package:evento/core/shared/widgets/widget/choice_ticket_for_cancal.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/profile_pages/my_booking/view/widget/my_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/my_booking_controller.dart';

class UpComingList extends StatelessWidget {
  UpComingList({super.key});
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBookingController>(builder: (myBookingController) {
      return SingleChildScrollView(
        padding: padding(10, 10, 10, 10),
        child: Column(
          children: [
            ...List.generate(
                myBookingController.upComingBooking.length,
                (index) => MyBookingCard(
                      isCanceldSection: false,
                      eventBooking: myBookingController.upComingBooking[index].bookings,
                      leftButtonOnTap: () async {
                        await showButtonSheet(
                            context: context,
                            widget:  ChoiceTicketForCancalWidget(bookings: myBookingController.upComingBooking[index].bookings),
                            height: screenHeight * 0.7);
                      },
                      leftButtonTitle: "Cancel Booking",
                      bookingStatus: "Paid",
                      model: myBookingController
                          .upComingBooking[index].bookings[0].eventClass.event,
                    ))
          ].divide(const SizedBox(
            height: 10,
          )),
        ),
      );
    });
  }
}
