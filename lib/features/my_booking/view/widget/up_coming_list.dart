import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/cancale_booking.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/my_booking/view/widget/my_booking_card.dart';
import 'package:flutter/material.dart';

class UpComingList extends StatelessWidget {
  const UpComingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding(10,10,10,10),
      child: Column(
        children: [
          ...List.generate(6, (index) =>MyBookingCard(
            isCanceldSection: false,
            leftButtonOnTap: ()async {
              await showButtonSheet(context: context, widget: const CancelBookingWidget(), height:500);
            },
            leftButtonTitle:"Cancel Booking" ,
            bookingStatus: "Paid",
          ))
        ].divide(const SizedBox(height: 10,)),
      ),
    );
  }
}