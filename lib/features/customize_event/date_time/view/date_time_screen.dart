import '../../../../core/responsive/responsive.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import 'widgets/contact_information_form.dart';
import 'widgets/event_title.dart';
import 'widgets/next_step_button.dart';
import 'widgets/notes.dart';
import 'widgets/select_people_date_time.dart';
import 'widgets/slider.dart';
import 'widgets/step_text.dart';
import 'widgets/upload_media.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeScreen extends StatelessWidget {
  const DateTimeScreen({super.key});

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
        padding: padding(16, 16, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const StepText2(),
            const LinearPercentIndicatorWidget(),
            EventTitle(),
            ContactInformationForm(),
            const SelectPeopleDateTime(),
            UploadMedia(),
            NotesLabel(),
            NextStepButton()
          ].divide(SizedBox(
            height: scaleHeight(10),
          )),
        ),
      ),
    );
  }
}
