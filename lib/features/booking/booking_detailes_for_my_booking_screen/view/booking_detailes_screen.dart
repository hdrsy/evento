import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/view/widget/build_buttons.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/view/widget/event_info_card.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/view/widget/ticket_detailes_card.dart';

import '../../../../core/responsive/responsive.dart';
import '../controller/booking_detailes_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class BookingDetailesForMyBookingScreen extends StatelessWidget {
  BookingDetailesForMyBookingScreen({super.key});
  final BookingDetailesForMyBookingController bookingDetailesController =
      Get.put(BookingDetailesForMyBookingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Booking Detailes"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: GetBuilder<BookingDetailesForMyBookingController>(
            builder: (controller) {
          return controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: customColors.primary),
                )
              : controller.isError.value
                  ? EmptyData(
                      icon: Icons.error_outline_outlined,
                      message: "SomeThing Wrong!!",
                    )
                  : controller.userBookings.isEmpty
                      ? Center()
                      : SingleChildScrollView(
                          padding: padding(16, 24, 0, 24),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              EventInfoCard2(),
                              const SizedBox(
                                height: 16,
                              ),
                              ...List.generate(
                                  bookingDetailesController.userBookings.length,
                                  (index) => TicketDetailesCardForMyBooking(
                                        ticketModel: bookingDetailesController
                                            .userBookings[index],
                                        modelIndex: index,
                                      )),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 30, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Your booking has been completed",
                                      style: customTextStyle.titleMedium,
                                    ).tr(),
                                    Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 0),
                                        child: BuildButton2()),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        );
        }),
      ),
    );
  }
}
