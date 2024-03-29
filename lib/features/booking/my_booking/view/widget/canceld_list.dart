import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/features/booking/my_booking/view/widget/my_booking_card.dart';
import 'package:evento/main.dart';

import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../controller/my_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CanceledList extends StatelessWidget {
  CanceledList({super.key});
  final MyBookingController myBookingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => myBookingController.isLoadingCancall.value
        ? Center(
            child: CircularProgressIndicator(
              color: customColors.primary,
            ),
          )
        : myBookingController.isErrorCanceled.value
            ? EmptyData(
                icon: Icons.error_outline_outlined,
                message: "SomeThing Wrong!!",
              )
            : myBookingController.cancelledBooking.isEmpty
                ? EmptyData(
                    icon: Icons.calendar_today,
                    message:
                        "No canceled bookings! Explore events to find your next great experience.",
                  )
                : SingleChildScrollView(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
                    child: Column(
                      children: [
                        Text("data"),
                        ...List.generate(
                            myBookingController.cancelledBooking.length,
                            (index) => MyBookingCard(
                                  isCanceldSection: true,
                                  bookingStatus: tr("Canceled"),
                                  model: myBookingController
                                      .cancelledBooking[index].event,
                                ))
                      ].divide(const SizedBox(
                        height: 10,
                      )),
                    ),
                  ));
  }
}
