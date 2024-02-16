import 'package:easy_localization/easy_localization.dart';
import 'package:evento/features/customize_event/date_time/controller/date_time_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  DateTimeScreen({super.key});
  final DateTimeController dateTimeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        title: Text(tr("Customize Your Event"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
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
            SelectPeopleDateTime(),
            UploadMedia(),
            NotesLabel(),
            SizedBox(
              height: 10.h,
            ),
            NextStepButton()
          ].divide(SizedBox(
            height: scaleHeight(0),
          )),
        ),
      ),
    );
  }
}
