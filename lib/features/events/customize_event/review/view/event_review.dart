import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/error_messages/error_messages.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/events/customize_event/date_time/controller/date_time_controller.dart';
import 'package:evento/main.dart';
import '../controller/event_review_controller.dart';
import 'widgets/additional_note.dart';
import 'widgets/proccess_to_payment_button.dart';
import 'widgets/review_card.dart';
import 'widgets/slider.dart';
import 'widgets/step_text4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class EventReviewScreen extends StatelessWidget {
  EventReviewScreen({super.key});
  final EventReviewController eventReviewController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
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
      body: SingleChildScrollView(
        padding: padding(16, 24, 16, 24),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const StepText4(),
              const LinearPercentIndicatorWidget4(),
              ReviewCard(
                onTapEdit: () {
                  final DateTimeController dateTimeController = Get.find();
                  dateTimeController.isEdit.value = true;
                  Get.toNamed('/dateTimeScreen');
                },
                title: tr("Contact Detailes"),
                leftColumnData: [
                  tr("Name"),
                  tr("Phone Number"),
                  tr("Number of Adults"),
                  tr("Number of Children"),
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
                onTapEdit: () {
                  final DateTimeController dateTimeController = Get.find();
                  dateTimeController.isEdit.value = true;
                  Get.toNamed('/dateTimeScreen');
                },
                title: tr("Event Overview"),
                leftColumnData: [
                  tr("Event Title"),
                  tr("Start Time"),
                  tr("End Time"),
                  tr("Date")
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
                onTapEdit: () {
                  Get.back();
                },
                title: tr("Event Crew"),
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
              ProccessToPaymentButton(),
              ...List.generate(
                  eventReviewController.errorMessage.length,
                  (index) => ErrorMessages(
                        message: eventReviewController.errorMessage[index],
                      )),
            ].divide(SizedBox(
              height: scaleHeight(10),
            )),
          ),
        ),
      ),
    );
  }
}
