import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/widget/choice_ticket_for_cancal.dart';
import 'package:evento/features/booking/my_booking/controller/my_booking_controller.dart';
import 'package:evento/features/booking/resell/controller/resell_controller.dart';
import 'package:evento/features/booking/resell/view/widget/choice_ticket_for_resell.dart';

import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class MoreOptionsWidget extends StatelessWidget {
  MoreOptionsWidget({
    required this.modelIndex,
    Key? key,
  }) : super(key: key);
  final int modelIndex;
  final MyBookingController myBookingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      onPressed: () async {
                        Get.back();
                        await showButtonSheet(
                            context: context,
                            widget: ChoiceTicketForCancalWidget(
                              bookings: myBookingController
                                  .upComingBooking[modelIndex].upcomingBookings,
                            ),
                            height: screenHeight * 0.7);
                      },
                      text: tr("Cancel Booking"),
                      options: ButtonOptions(
                        width: 150,
                        height: 45,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                      onPressed: () {
                        Get.back();
                        Get.put(ReSellController());
                        showButtonSheet(
                            context: context,
                            widget: ChoiceTicketForReSellWidget(
                              bookings: myBookingController
                                  .upComingBooking[modelIndex].upcomingBookings,
                            ),
                            height: screenHeight * 0.7);
                      },
                      text: tr("Resell Ticket"),
                      options: ButtonOptions(
                        width: 150,
                        height: 45,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
        ),
      ),
    );
  }
}
