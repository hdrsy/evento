import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/snak_bar/snak_bar_for_errors.dart';
import 'package:evento/features/events/customize_event/type_to_set_event/controller/type_to_set_event_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomizeEventButton extends StatelessWidget {
  const CustomizeEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onPressed: () async {
        TypetoSetEventController typetoSetEventController = Get.find();
        if (typetoSetEventController.selectedCategory.value != 0) {
          Get.toNamed('/ServiceCategoryScreen');
        } else {
          snakBarForError(tr("Please Choice Your Event Type"));
        }
      },
      text: tr("Customize Event"),
      icon: Icon(
        Icons.settings,
        color: customColors.info,
        size: 15,
      ),
      options: ButtonOptions(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.primary,
        textStyle:
            customTextStyle.titleSmall.copyWith(color: customColors.info),
        elevation: 3,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
