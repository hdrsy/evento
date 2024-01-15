import '../../../../core/server/server_config.dart';
import '../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/widget/rate_event_widget.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../../booking_detailes/controller/booking_detailes_controller.dart';
import '../../controller/booking_detailes_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class BuildButton extends StatelessWidget {
   BuildButton({super.key});

      final BookingDetailesForMyBookingController bookingDetailesController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonWidget(
          onPressed: () {
      
      bookingDetailesController.openPdf();
          },
          text:tr( "Download Ticket"),
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
                widget:  ReviewEventWidget(ratingTarget:tr( "Your Event"),id:bookingDetailesController.eventDetailsModel.id,idKey: "event_id",url: ServerConstApis.reviewEvent, ),
                height: 450);
          },
          text:tr( "Review Event"),
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
