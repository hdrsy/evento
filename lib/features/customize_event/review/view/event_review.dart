import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/customize_event/review/controller/event_review_controller.dart';
import 'package:evento/features/customize_event/review/view/widgets/additional_note.dart';
import 'package:evento/features/customize_event/review/view/widgets/proccess_to_payment_button.dart';
import 'package:evento/features/customize_event/review/view/widgets/review_card.dart';
import 'package:evento/features/customize_event/review/view/widgets/slider.dart';
import 'package:evento/features/customize_event/review/view/widgets/step_text4.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventReviewScreen extends StatelessWidget {
  EventReviewScreen({super.key});
  final EventReviewController eventReviewController = Get.find();
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
            ReviewCard(
              title: "Contact Detailes",
              leftColumnData: const [
                "Name",
                "Phone Number",
                "Number of Adults",
                "Number of Children",
              ],
              rightColumnData: [
                eventReviewController.contactInfoModel.firstName +
                    eventReviewController.contactInfoModel.lastName,
                eventReviewController.contactInfoModel.phoneNumber,
                "${eventReviewController.contactInfoModel.adultNumber} people",
                "${eventReviewController.contactInfoModel.childrenNumber} people"
              ],
            ),
            ReviewCard(
              title: "Event Overview",
              leftColumnData: const [
                "Event Title",
                "Start Time",
                "End Time",
                "Date"
              ],
              rightColumnData: [
                "La Rose",
                DateFormatter.formatTime(
                    eventReviewController.eventOverView.startTime),
                DateFormatter.formatTime(
                    eventReviewController.eventOverView.endTime),
                DateFormatter.formatDate(
                    eventReviewController.eventOverView.date),
              ],
            ),
            ReviewCard(
              title: "Event Crew",
              leftColumnData: eventReviewController.selected.values
                  .map((value) => value.toString())
                  .toList(),
              rightColumnData: eventReviewController.selected.keys
                  .map((value) => value.toString())
                  .toList(),
            ),
            AdditionalNote(
              controller: eventReviewController.notes,
              onChange: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            ProccessToPaymentButton()
          ].divide(SizedBox(
            height: scaleHeight(10),
          )),
        ),
      ),
    );
  }
}
