import 'package:barcode_widget/barcode_widget.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/book_now/model/ticket_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class TicketDetailesCard extends StatelessWidget {
  const TicketDetailesCard({super.key, required this.ticketModel, required this.modelIndex});
final TicketModel ticketModel;
final int modelIndex;
  @override
  Widget build(BuildContext context) {
    return 
        Column(
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
          "Ticket ${modelIndex+1}",
          style: customTextStyle.headlineMedium.override(
            color: customColors.primary,
            fontFamily: secondaryFontFamily,
            useGoogleFonts: true
          ),
        ),
      ),
    ],
  ),
)
,
            Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              boxShadow:const [
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
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Text(
                       "Attendee Information",
                      style: customTextStyle.headlineMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AttendeeInfoLeftColumn(title: "Full Name"),
                          const AttendeeInfoLeftColumn(title: "Age"),
                          const AttendeeInfoLeftColumn(title: "Phone Number"),
                        ].divide(const SizedBox(height: 8)),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                           AttendeeInfoRightColumn(title: "${ticketModel.fisrtName.text} ${ticketModel.lastName.text}"),
                           AttendeeInfoRightColumn(title: ticketModel.age.text),
                           AttendeeInfoRightColumn(title: ticketModel.phoneNumber.text),
                        ].divide(const SizedBox(height: 8)),
                      ),
                    ].divide(const SizedBox(width: 8)),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: customColors.secondary,
                ),
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Text(
                      " Payment Summary",
                      style: customTextStyle.headlineMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                             "Coupon code",
                            style:
                                customTextStyle.labelMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.secondaryText,
                                      fontSize: 14,
                                      useGoogleFonts: false,
                                    ),
                          ),
                          Text(
                            " EventoR7",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Ticket",
                            style:
                                customTextStyle.labelMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.secondaryText,
                                      fontSize: 14,
                                      useGoogleFonts: false,
                                    ),
                          ),
                          Text(
                             "100,000 sp",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                             "Tax",
                            style:
                                customTextStyle.labelMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.secondaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                          ),
                          Text(
                             "20,000 sp",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                             "Discount",
                            style:
                                customTextStyle.labelMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.secondaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                          ),
                          Text(
                             "20%",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        indent: 50,
                        endIndent: 50,
                        color: customColors.secondary,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Total",
                            style:
                                customTextStyle.labelMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.secondaryText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: false,
                                    ),
                          ),
                          Text(
                             "120,000 sp",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: false,
                            ),
                          ),
                        ],
                      ),
                    ].divide(const SizedBox(height: 8)),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: customColors.secondary,
                ),
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Text(
                      " Payment Confirmation",
                      style: customTextStyle.headlineMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                             "Payment Methods",
                            style:
 customTextStyle.labelMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.secondaryText,
                                      fontSize: 14,
                                      useGoogleFonts: false,
                                    ),
                          ),
                          Text(
                            "Order ID",
                            style:
                                customTextStyle.labelMedium.override(
                                      fontFamily: 'Nunito',
                                      color: customColors.secondaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                          ),
                          Text(
                            "Status",
                            style: customTextStyle.labelMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.secondaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                          ),
                        ].divide(const SizedBox(height: 8)),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "MasterCard",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                          ),
                          Text(
                            "75849302938",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                          ),
                          ButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: "Paid",
                            options: ButtonOptions(
                              height: 22,
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              iconPadding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: customColors.secondaryBackground,
                              textStyle: customTextStyle.titleSmall.override(
                                fontFamily: 'Nunito',
                                color: customColors.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: false,
                              ),
                              borderSide: BorderSide(
                                color: customColors.alternate,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ].divide(const SizedBox(height: 8)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    ),
          ],
        );
  }
}

class AttendeeInfoRightColumn extends StatelessWidget {
  const AttendeeInfoRightColumn({
    super.key,
    required this.title
  });
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
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
       title,
      style:
          customTextStyle.labelMedium.override(
                fontFamily: 'Nunito',
                color: customColors.secondaryText,
                fontSize: 14,
                useGoogleFonts: false,
              ),
    );
  }
}
