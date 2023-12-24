import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/my_booking/view/widget/my_booking_card.dart';
import 'package:flutter/material.dart';

class CanceledList extends StatelessWidget {
  const CanceledList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(24,10,24,10),
      child: Column(
        children: [
          ...List.generate(6, (index) =>const MyBookingCard(
            isCanceldSection: true,
            bookingStatus: "Canceled",
          ))
        ].divide(const SizedBox(height: 10,)),
      ),
    );
  }
}