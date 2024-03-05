import 'package:barcode_widget/barcode_widget.dart';
import 'package:evento/features/booking/my_booking/model/up_coming_booking.dart';
import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../book_now/model/ticket_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TicketDetailesCardForMyBooking extends StatelessWidget {
  const TicketDetailesCardForMyBooking(
      {super.key, required this.ticketModel, required this.modelIndex});
  final Booking ticketModel;
  final int modelIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: AlignmentDirectional(-1, -1),
                child: Text(
                  "Ticket ${modelIndex + 1}",
                  style: customTextStyle.headlineMedium.override(
                      color: customColors.primary,
                      fontFamily: secondaryFontFamily,
                      useGoogleFonts: true),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: customColors.secondary,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: BarcodeWidget(
                      data: 'Barcode',
                      barcode: Barcode.qrCode(),
                      width: 200,
                      height: 200,
                      color: customColors.primaryText,
                      backgroundColor: Colors.transparent,
                      errorBuilder: (_context, _error) => const SizedBox(
                        width: 200,
                        height: 200,
                      ),
                      drawText: false,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Text(
                    "Attendee Information",
                    style: customTextStyle.headlineMedium,
                  ).tr(),
                ),
                SinglePriceElement(
                  title: "firstName",
                  subTitle: ticketModel.firstName,
                ),
                SinglePriceElement(
                  title: "lastName",
                  subTitle: ticketModel.lastName,
                ),
                SinglePriceElement(
                  title: "phoneNumber",
                  subTitle: ticketModel.phoneNumber,
                ),
                SinglePriceElement(
                  title: "age",
                  subTitle: ticketModel.age.toString(),
                ),
                // SinglePriceElement(
                //   title: "age",
                //   subTitle: ticketModel.,
                // ),
                Divider(
                  thickness: 1,
                  color: customColors.secondary,
                ),
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Text(
                    "Payment Summary",
                    style: customTextStyle.headlineMedium,
                  ).tr(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                          ticketModel.amenities.length,
                          (index) => SinglePriceElement(
                                title: ticketModel.amenities[index].title,
                                subTitle: ticketModel
                                    .amenities[index].pivot.price
                                    .toString(),
                              )),
                      Divider(
                        thickness: 1,
                        indent: 50,
                        endIndent: 50,
                        color: customColors.secondary,
                      ),
                      // SinglePriceElement(
                      //           title: ticketModel.,
                      //           subTitle: ticketModel
                      //               .amenities[index].pivot.price
                      //               .toString(),
                      //         )
                    ].divide(const SizedBox(height: 8)),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: customColors.secondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SinglePriceElement extends StatelessWidget {
  const SinglePriceElement({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: customTextStyle.labelMedium.override(
            fontFamily: 'Nunito',
            color: customColors.secondaryText,
            fontSize: 14,
            useGoogleFonts: false,
          ),
        ).tr(),
        Text(
          subTitle,
          style: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            color: customColors.primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            useGoogleFonts: false,
          ),
        ).tr(),
      ],
    );
  }
}

class AttendeeInfoRightColumn extends StatelessWidget {
  const AttendeeInfoRightColumn({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: customTextStyle.bodyMedium.override(
        fontFamily: 'Nunito',
        color: customColors.primaryText,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        useGoogleFonts: false,
      ),
    );
  }
}

class AttendeeInfoLeftColumn extends StatelessWidget {
  const AttendeeInfoLeftColumn({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: customTextStyle.labelMedium.override(
        fontFamily: 'Nunito',
        color: customColors.secondaryText,
        fontSize: 14,
        useGoogleFonts: false,
      ),
    );
  }
}
