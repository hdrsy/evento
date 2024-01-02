import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/review/controller/event_review_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProccessToPaymentButton extends StatelessWidget {
  ProccessToPaymentButton({super.key});
  final EventReviewController eventReviewController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ButtonWidget(
        onPressed: () async {
          eventReviewController.onPressDone();
        },
        showLoadingIndicator: eventReviewController.isLoading.value,
        text: "Proceed to Payment",
        options: ButtonOptions(
          height: 40,
          width: screenWidth*0.5,
          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: customColors.primary,
          textStyle: customTextStyle.titleSmall.override(
            fontFamily: primaryFontFamily,
            useGoogleFonts: true,
            color: customColors.info,
          ),
          elevation: 3,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
