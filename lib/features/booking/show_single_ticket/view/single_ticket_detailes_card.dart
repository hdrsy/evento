import 'package:barcode_widget/barcode_widget.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/utils/helper/number_formatter.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/model/booking_detailes_for_my_booking_model.dart';
import 'package:evento/features/booking/resell/controller/resell_controller.dart';
import 'package:evento/features/booking/resell/view/resell_screen.dart';
import 'package:evento/features/booking/show_single_ticket/controller/show_single_ticket_controller.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SingleTicketDetailesCardForMyBooking extends StatelessWidget {
  SingleTicketDetailesCardForMyBooking(
      {super.key, required this.ticketModel, required this.modelIndex});
  final UserBooking ticketModel;
  final int modelIndex;
  final ShowSingleTicketController bookingDetailesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
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
                      data:
                          'https://evento.sy/#/ShowSingleTicketScreen?id=${ticketModel.id}',
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
                      SinglePriceElement(
                        title: "${tr("Ticket Class")}: ",
                        subTitle: ticketModel.classType,
                      ),
                      SinglePriceElement(
                        title: "${tr("Original Price")}:",
                        subTitle: formatPrice(ticketModel.event.classes
                                .where((element) =>
                                    element.id == ticketModel.classId)
                                .first
                                .ticketPrice) +
                            " ${tr("sp")}",
                      ),
                      ticketModel.promoCode == null && ticketModel.offer == null
                          ? SizedBox()
                          : SinglePriceElement(
                              title: "${tr("Discounts")}:",
                              subTitle: "",
                            ),
                      ticketModel.offer == null
                          ? SizedBox()
                          : SinglePriceElement(
                              title:
                                  "${tr("Event Discount")} (${ticketModel.offer!.percent}%):",
                              subTitle: formatPrice(bookingDetailesController
                                      .calclateofferDiscountForClass(
                                          ticketModel.offer!,
                                          ticketModel.event.classes
                                              .where((element) =>
                                                  element.id ==
                                                  ticketModel.classId)
                                              .first
                                              .ticketPrice)) +
                                  " ${tr("sp")}"),
                      ticketModel.promoCode == null
                          ? SizedBox()
                          : SinglePriceElement(
                              title:
                                  "${tr("Promo Code Discount")} (${ticketModel.promoCode!.discount}%):",
                              subTitle: formatPrice(bookingDetailesController
                                      .calculateDiscountForTicket(
                                          ticketModel.promoCode!, modelIndex)) +
                                  " ${tr("sp")}"),
                      ticketModel.promoCode == null && ticketModel.offer == null
                          ? SizedBox()
                          : SinglePriceElement(
                              title: "${tr("Price after Discount")}:",
                              subTitle: formatPrice(bookingDetailesController
                                      .calclatepiceaftediscount(modelIndex)) +
                                  " ${tr("sp")}",
                            ),
                      ticketModel.amenities.isEmpty
                          ? SizedBox()
                          : SinglePriceElement(
                              title: "${tr("Additional Services")}:",
                              subTitle: "",
                            ),
                      ...List.generate(
                          ticketModel.amenities.length,
                          (index) => SinglePriceElement(
                                title: ticketModel.amenities[index].title,
                                subTitle: formatPrice(ticketModel
                                        .event.amenities
                                        .where((element) =>
                                            element.id ==
                                            ticketModel.amenities[index].id)
                                        .first
                                        .pivot
                                        .price!) +
                                    " ${tr("sp")}",
                              )),
                    ].divide(const SizedBox(height: 8)),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: customColors.secondary,
                ),
                SinglePriceElement(
                  title: "Total Price",
                  subTitle: formatPrice(ticketModel.classTicketPrice) +
                      " ${tr("sp")}",
                ),
                SizedBox(
                  height: 5,
                )
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
