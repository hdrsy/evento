import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/features/booking/my_booking/view/widget/more_options_widget.dart';
import 'package:evento/main.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
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
          : myBookingController.isErrorUpComing.value
              ? EmptyData(
                  icon: Icons.error_outline_outlined,
                  message: "SomeThing Wrong!!",
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
                              (index) {
                            return MyBookingCard(
                                isCanceldSection: false,
                                eventBooking:
                                    myBookingController.upComingBooking[index],
                                leftButtonOnTap: () async {
                                  showButtonSheet(
                                      context: context,
                                      widget: MoreOptionsWidget(
                                        modelIndex: index,
                                      ),
                                      height: screenHeight * 0.15);
                                },
                                leftButtonTitle: tr("More Options"),
                                bookingStatus: tr("Paid"),
                                model: myBookingController
                                    .upComingBooking[index]
                                    .upcomingBookings[0]
                                    .event);
                          })
                        ].divide(const SizedBox(
                          height: 10,
                        )),
                      ),
                    );
    });
  }
}
