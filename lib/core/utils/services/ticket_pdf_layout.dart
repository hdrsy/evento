import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/helper/number_formatter.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/controller/booking_detailes_controller.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/model/booking_detailes_for_my_booking_model.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget buildTicketCard(UserBooking ticketModel, int modelIndex) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      buildTicketHeader(modelIndex),
      pw.Padding(
        padding: const pw.EdgeInsets.all(8),
        child: pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColor(0.9, 0.9, 0.9), // Example gray color
              borderRadius: pw.BorderRadius.circular(16),
              border: pw.Border.all(
                color: PdfColor(
                    0.8, 0.8, 0.8), // Example border color, adjust as needed
              ),
            ),
            child: pw.Column(mainAxisSize: pw.MainAxisSize.max, children: [
              buildQrCodeSection(ticketModel.id),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: pw.Text(
                    "Attendee Information",
                    style: pw.TextStyle(
                      // Define the text style similar to your customTextStyle
                      fontSize: 18, // Example font size
                      fontWeight: pw.FontWeight.bold,
                      // Color can be set if needed, e.g., PdfColors.black
                    ),
                  ),
                ),
              ),
              buildAttendeeInformation(ticketModel),
              pw.Divider(
                thickness: 1, // Set the thickness of the divider
                color: PdfColors.grey, // Replace with your custom color
              ),
              buildPaymentSummaryTitle(),
              buildPaymentSummary(ticketModel, modelIndex),
            ])),
      )
    ],
  );
}

pw.Widget singlePriceElement(String title, String subTitle) {
  return pw.Row(
    mainAxisSize: pw.MainAxisSize.max,
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 14,
        ),
      ),
      pw.Text(
        subTitle,
        style: pw.TextStyle(
          fontSize: 14,
        ),
      ),
    ],
  );
}

pw.Widget buildPaymentSummary(UserBooking ticketModel, int modelIndex) {
  final labelStyle = pw.TextStyle(
    fontSize: 14,
    fontWeight: pw.FontWeight.normal,
    // Set color if needed
  );

  final valueStyle = pw.TextStyle(
    fontSize: 14,
    fontWeight: pw.FontWeight.bold,
    // Set color if needed
  );
  final BookingDetailesForMyBookingController bookingDetailesController =
      Get.find();
  return pw.Padding(
    padding: const pw.EdgeInsets.all(10),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        singlePriceElement("Ticket Class", ticketModel.classType),
        // ... Add other Rows here ...
        singlePriceElement(
          "${tr("Original Price")}:",
          formatPrice(ticketModel.event.classes
                  .where((element) => element.id == ticketModel.classId)
                  .first
                  .ticketPrice) +
              " ${tr("sp")}",
        ),
        ticketModel.promoCode == null && ticketModel.offer == null
            ? pw.SizedBox()
            : singlePriceElement(
                "${tr("Discounts")}:",
                "",
              ),
        ticketModel.offer == null
            ? pw.SizedBox()
            : singlePriceElement(
                "${tr("Event Discount")} (${ticketModel.offer!.percent}%):",
                formatPrice(bookingDetailesController
                        .calclateofferDiscountForClass(
                            ticketModel.offer!,
                            ticketModel.event.classes
                                .where((element) =>
                                    element.id == ticketModel.classId)
                                .first
                                .ticketPrice)) +
                    " ${tr("sp")}"),
        ticketModel.promoCode == null
            ? pw.SizedBox()
            : singlePriceElement(
                "${tr("Promo Code Discount")} (${ticketModel.promoCode!.discount}%):",
                formatPrice(
                        bookingDetailesController.calculateDiscountForTicket(
                            ticketModel.promoCode!, modelIndex)) +
                    " ${tr("sp")}"),
        ticketModel.promoCode == null && ticketModel.offer == null
            ? pw.SizedBox()
            : singlePriceElement(
                "${tr("Price after Discount")}:",
                formatPrice(bookingDetailesController
                        .calclatepiceaftediscount(modelIndex)) +
                    " ${tr("sp")}",
              ),
        ticketModel.amenities.isEmpty
            ? pw.SizedBox()
            : singlePriceElement(
                "${tr("Additional Services")}:",
                "",
              ),
        ...List.generate(
            ticketModel.amenities.length,
            (index) => singlePriceElement(
                  ticketModel.amenities[index].title,
                  formatPrice(ticketModel.event.amenities
                          .where((element) =>
                              element.id == ticketModel.amenities[index].id)
                          .first
                          .pivot
                          .price!) +
                      " ${tr("sp")}",
                )),
        pw.Divider(
          thickness: 1,
          color: PdfColors.grey, // Replace with your custom color
        ),
        singlePriceElement(
          "Total Price",
          formatPrice(ticketModel.classTicketPrice) + " ${tr("sp")}",
        ),
        pw.SizedBox(
          height: 5,
        )
      ],
    ),
  );
}

pw.Widget buildPaymentSummaryTitle() {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Padding(
      padding: const pw.EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: pw.Text(
        "Payment Summary",
        style: pw.TextStyle(
          fontSize: 14, // Adjust font size as needed
          fontWeight: pw.FontWeight.bold,
          // If you have a custom color, set it like: color: PdfColors.yourColor
        ),
      ),
    ),
  );
}

pw.Widget buildTicketHeader(int modelIndex) {
  return pw.Padding(
    padding: const pw.EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          "Ticket ${modelIndex + 1}",
          style: pw.TextStyle(
            fontSize: 18, // Adjust the font size as needed
            fontWeight: pw.FontWeight.bold,
            // You can set the color like this if needed:
            color: PdfColor.fromInt(customColors.primary.value),
          ),
        ),
      ],
    ),
  );
}

pw.Widget buildQrCodeSection(int id) {
  return pw.Align(
    alignment: pw.Alignment.center,
    child: pw.Padding(
      padding: const pw.EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(),
        data: 'https://evento.sy/#/ShowSingleTicketScreen?id=${id}',
        width: 200,
        height: 200,
        color: PdfColors.black, // Adjust the color as needed
        // Background color is not available in the same way as Flutter UI
        drawText:
            false, // Set to true if you want to display the data below the QR code
      ),
    ),
  );
}

pw.Widget buildAttendeeInformation(UserBooking ticketModel) {
  final textStyle = pw.TextStyle(
    fontSize: 12, // Example font size
    fontWeight: pw.FontWeight.normal,
  );

  return pw.Padding(
    padding: const pw.EdgeInsets.all(10),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Full Name", style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text("Age", style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text("Phone Number", style: textStyle),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("${ticketModel.firstName} ${ticketModel.lastName}",
                style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text(ticketModel.age.toString(), style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text(ticketModel.phoneNumber, style: textStyle),
          ],
        ),
      ],
    ),
  );
}
