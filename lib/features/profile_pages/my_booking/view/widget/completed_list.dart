import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/shared/widgets/widget/rate_event_widget.dart';
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
  final MyBookingController myBookingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => myBookingController.isLoading.value
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
            : myBookingController.completedBooking.isEmpty
                ? const EmptyData(
                    icon: Icons.calendar_today,
                    message:
                        "No completed bookings! Explore events to find your next great experience.",
                  )
                : SingleChildScrollView(
                    padding: padding(10, 24, 10, 24),
                    child: Column(
                      children: [
                        ...List.generate(
                            myBookingController.completedBooking.length,
                            (index) => MyBookingCard(
                                  eventBooking: myBookingController
                                      .completedBooking[index].bookings,
                                  model: myBookingController
                                      .completedBooking[index]
                                      .bookings[0]
                                      .eventClass
                                      .event,
                                  isCanceldSection: false,
                                  leftButtonOnTap: () {
                                    showButtonSheet(
                                        context: context,
                                        widget: ReviewEventWidget(
                                          ratingTarget: tr("Your Event"),
                                          id: myBookingController
                                              .completedBooking[index]
                                              .bookings[0]
                                              .eventClass
                                              .event
                                              .id,
                                          idKey: "event_id",
                                          url: ServerConstApis.reviewEvent,
                                        ),
                                        height: 450);
                                  },
                                  leftButtonTitle: tr("Leave a Review"),
                                  bookingStatus: tr("Completed"),
                                ))
                      ].divide(const SizedBox(
                        height: 10,
                      )),
                    ),
                  ));
  }
}
