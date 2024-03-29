import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/main.dart';
import '../controller/type_to_set_event_controller.dart';
import 'widgets/customize_event_button.dart';
import 'widgets/event_types_widget.dart';
import 'widgets/slider.dart';
import 'widgets/step_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class TypeToSetEventScreen extends StatelessWidget {
  TypeToSetEventScreen({super.key});
  final TypetoSetEventController typetoSetEventController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          surfaceTintColor: customColors.secondaryBackground,
          backgroundColor: customColors.secondaryBackground,
          title: Text(tr("Customize Your Event"),
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
        ),
        body: Obx(
          () => typetoSetEventController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                  color: customColors.primary,
                ))
              : typetoSetEventController.IsErrorExist.value
                  ? EmptyData(
                      icon: Icons.error_outline_outlined,
                      message: "SomeThing Wrong!!",
                    )
                  : typetoSetEventController.categoryList.isEmpty
                      ? EmptyData(
                          icon: Icons.settings,
                          message:
                              "Looks like there are no  events available right now - check back later!")
                      : Container(
                          padding: padding(16, 16, 16, 16),
                          width: double.infinity,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const StepText(),
                                const LinearPercentIndicatorWidget(),
                                EventTypesWidget(),
                                Spacer(),
                                const CustomizeEventButton()
                              ].divide(SizedBox(
                                height: scaleHeight(10),
                              ))),
                        ),
        ));
  }
}
