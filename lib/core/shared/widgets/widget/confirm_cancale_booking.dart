import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/widget/succeful_cancale_booking.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/booking/my_booking/controller/cancel_booking_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class ConfirmCancelBookingWidget extends StatelessWidget {
  const ConfirmCancelBookingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            child: Divider(
              thickness: 3,
              color: customColors.secondary,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Are you sure you want to cancel this event?",
                textAlign: TextAlign.center,
                style: customTextStyle.headlineSmall,
              ).tr(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  "Only 8% funds will be returned to your account according to our policy.",
                  textAlign: TextAlign.center,
                  style: customTextStyle.bodyMedium,
                ).tr(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  onPressed: () async {
                    Get.back();
                  },
                  text: tr("No,Don't Cancel"),
                  options: ButtonOptions(
                    width: 150,
                    height: 45,
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: customColors.secondaryBackground,
                    textStyle: customTextStyle.titleSmall.override(
                      fontFamily: 'Nunito',
                      color: customColors.primaryText,
                      fontSize: 14,
                      useGoogleFonts: true,
                    ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: customColors.primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  showLoadingIndicator: false,
                ),
                ButtonWidget(
                  onPressed: () async {
                    Get.back();
                    final CancelBookingController cancelBookingController =
                        Get.put(CancelBookingController());
                    await cancelBookingController.onPressCancell();
                    if (cancelBookingController.cancellState) {
                      Get.back();
                      showButtonSheet(
                          context: context,
                          widget: const SuccefulCancelBookingWidget(),
                          height: 600);
                    }
                  },
                  text: tr("Yes,cancel"),
                  options: ButtonOptions(
                    width: 150,
                    height: 45,
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: customColors.rejected,
                    textStyle: customTextStyle.titleSmall.override(
                      fontFamily: 'Nunito',
                      color: customColors.info,
                      fontSize: 14,
                      useGoogleFonts: true,
                    ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: customColors.rejected,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  showLoadingIndicator: false,
                ),
              ],
            ),
          ),
        ].divide(const SizedBox(height: 8)),
      ),
    );
  }
}
