import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/main.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../../core/shared/widgets/widget/choice_ticket_for_cancal.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import 'my_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/my_booking_controller.dart';
import 'package:easy_localization/easy_localization.dart';

class UpComingList extends StatelessWidget {
  const UpComingList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBookingController>(builder: (myBookingController) {
      return myBookingController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: customColors.primary,
              ),
            )
          : myBookingController.upComingBooking.isEmpty
              ? const EmptyData(
                  icon: Icons.calendar_today,
                  message:
                      "No upcoming bookings! Explore events to find your next great experience.",
                )
              : SingleChildScrollView(
                  padding: padding(10, 10, 10, 10),
                  child: Column(
                    children: [
                      ...List.generate(
                          myBookingController.upComingBooking.length,
                          (index) => MyBookingCard(
                                isCanceldSection: false,
                                eventBooking: myBookingController
                                    .upComingBooking[index].bookings,
                                leftButtonOnTap: () async {
                                  await showButtonSheet(
                                      context: context,
                                      widget: ChoiceTicketForCancalWidget(
                                          bookings: myBookingController
                                              .upComingBooking[index].bookings),
                                      height: screenHeight * 0.7);
                                },
                                leftButtonTitle: tr("Cancel Booking"),
                                bookingStatus: tr("Paid"),
                                model: myBookingController
                                    .upComingBooking[index]
                                    .bookings[0]
                                    .eventClass
                                    .event,
                              ))
                    ].divide(const SizedBox(
                      height: 10,
                    )),
                  ),
                );
    });
  }
}
