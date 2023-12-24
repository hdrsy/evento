import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/my_booking/view/widget/my_booking_card.dart';
import 'package:flutter/material.dart';

class CompletedList extends StatelessWidget {
  const CompletedList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding(10,24,10,24),
      child: Column(
        children: [
          ...List.generate(6, (index) =>MyBookingCard(
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