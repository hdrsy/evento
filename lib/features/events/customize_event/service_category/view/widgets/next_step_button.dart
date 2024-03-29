import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/snak_bar/snak_bar_for_errors.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/customize_event/service_category/controller/service_category_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextStepButton extends StatelessWidget {
  const NextStepButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onPressed: () async {
        ServiceCategoryController serviceCategoryController = Get.find();
        bool isDoneone = serviceCategoryController.selectedServiceProviders
            .any((element) => element.value != 0);
        if (serviceCategoryController.selectedVenue.value != 0 && isDoneone) {
          Get.toNamed('/dateTimeScreen');
        } else {
          if (!isDoneone) {
            snakBarForError(tr("select_service_provider"));
          } else {
            snakBarForError(tr("select_venue_first"));
          }
        }
      },
      text: tr("Next"),
      options: ButtonOptions(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.primary,
        textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          color: customColors.info,
          fontWeight: FontWeight.w500,
          useGoogleFonts: false,
        ),
        elevation: 3,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}
