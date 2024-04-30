import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/view/widget/ticket_detailes_card.dart';
import 'package:evento/features/booking/show_single_ticket/controller/show_single_ticket_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSingleTicketScreen extends StatelessWidget {
  const ShowSingleTicketScreen({super.key});

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
        child: GetBuilder<ShowSingleTicketController>(
            init: ShowSingleTicketController(),
            builder: (controller) {
              return controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                          color: customColors.primary),
                    )
                  : controller.isError.value
                      ? EmptyData(
                          icon: Icons.error_outline_outlined,
                          message: "SomeThing Wrong!!",
                        )
                      : SingleChildScrollView(
                          padding: padding(16, 24, 0, 24),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date Of Event",
                                    style: customTextStyle.bodyMedium,
                                  ).tr(),
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              // EventInfoCard2(),
                              const SizedBox(
                                height: 16,
                              ),
                              TicketDetailesCardForMyBooking(
                                ticketModel: controller.userBookings,
                                modelIndex: 0,
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
