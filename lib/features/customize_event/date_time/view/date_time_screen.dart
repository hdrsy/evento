import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/customize_event/date_time/view/widgets/contact_information_form.dart';
import 'package:evento/features/customize_event/date_time/view/widgets/next_step_button.dart';
import 'package:evento/features/customize_event/date_time/view/widgets/notes.dart';
import 'package:evento/features/customize_event/date_time/view/widgets/select_people_date_time.dart';
import 'package:evento/features/customize_event/date_time/view/widgets/slider.dart';
import 'package:evento/features/customize_event/date_time/view/widgets/step_text.dart';
import 'package:evento/features/customize_event/date_time/view/widgets/upload_media.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeScreen extends StatelessWidget {
  const DateTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: customColors.secondaryBackground,
     appBar:  AppBar(
      backgroundColor: customColors.secondaryBackground,
       
         leading:  InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(padding: padding(16,16,16,16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
        children: [
           const StepText2(),
              const LinearPercentIndicatorWidget(),
              ContactInformationForm(),
              const SelectPeopleDateTime(),
              const UploadMedia(),
              const NotesLabel(),
              const NextStepButton()
        ].divide(SizedBox(height: scaleHeight(10),)),
      ),
      
      )
      ,
    );
  }
}