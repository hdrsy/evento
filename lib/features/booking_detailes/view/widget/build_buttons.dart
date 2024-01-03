import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/widget/rate_event_widget.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/booking_detailes/controller/booking_detailes_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonWidget(
          onPressed: () {
      final BookingDetailesController bookingDetailesController=Get.find();
      
      bookingDetailesController.openPdf();
          },
          text: "Download Ticket",
          options: ButtonOptions(
            width: 170,
            height: 40,
            // padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.secondaryBackground,
            textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: customColors.primary,
              fontSize: 14,
              useGoogleFonts: true,
            ),
            elevation: 3,
            borderSide: BorderSide(
              color: customColors.primary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        ButtonWidget(
          onPressed: () async {
            await showButtonSheet(
                context: context,
                widget: const ReviewEventWidget(),
                height: 450);
          },
          text: "Review Event",
          options: ButtonOptions(
            width: 150,
            height: 40,
            // padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.primary,
            textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: customColors.primaryBtnText,
              fontSize: 14,
              useGoogleFonts: true,
            ),
            elevation: 3,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ],
    );
  }
}
