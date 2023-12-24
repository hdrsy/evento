import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/customize_event/review/view/widgets/additional_note.dart';
import 'package:evento/features/customize_event/review/view/widgets/proccess_to_payment_button.dart';
import 'package:evento/features/customize_event/review/view/widgets/review_card.dart';
import 'package:evento/features/customize_event/review/view/widgets/slider.dart';
import 'package:evento/features/customize_event/review/view/widgets/step_text4.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventReviewScreen extends StatelessWidget {
  const EventReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        leading: InkWell(
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
      body: SingleChildScrollView(
        padding: padding(16, 24, 16, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StepText4(),
            const LinearPercentIndicatorWidget4(),
            const ReviewCard(
              title: "Contact Detailes",
              leftColumnData: [
                "Name",
                "Phone Number",
                "Total Number of Guests"
              ],
              rightColumnData: ["Mohammad Ahmad", "0900000000", "7 people"],
            ),
            const ReviewCard(
              title: "Event Overview",
              leftColumnData: [
                "Event Title",
                "Start Time",
                "End Time",
                "Date"
              ],
              rightColumnData: ["La Rose", "5:00 pm", "10:00 pm","20/10/2023"],
            ),
            const ReviewCard(
              title: "Event Crew",
              leftColumnData: [
                "Venue Name",
                "Dress Shop",
                "Decoration",
                
              ],
              rightColumnData: ["La Rose", "Laura", "La Rose"],
            ),
            AdditionalNote(controller: TextEditingController(),onChange: (value){},),
            const SizedBox(height: 10,),
            const ProccessToPaymentButton()

          ].divide(SizedBox(
            height: scaleHeight(10),
          )),
        ),
      ),
    );
  }
}
