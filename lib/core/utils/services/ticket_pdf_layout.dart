import '../../../features/book_now/model/ticket_model.dart';
import '../../../main.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget buildTicketCard(TicketModel ticketModel, int modelIndex) {
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
              buildQrCodeSection(),
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
              buildPaymentSummary(),
              pw.Divider(
                thickness: 1, // Set the thickness of the divider
                color: PdfColors.grey, // Replace with your custom color
              ),
              buildPaymentConfirmationTitle(),
              buildPaymentDetails("card", "sss", "paid")
            ])),
      )
    ],
  );
}

pw.Widget buildPaymentDetails(
    String paymentMethod, String orderId, String status) {
  final textStyle = pw.TextStyle(
    fontSize: 14, // Example font size
    fontWeight: pw.FontWeight.normal,
    // Set color if needed
  );

  return pw.Padding(
    padding: const pw.EdgeInsets.all(10),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Payment Methods", style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text("Order ID", style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text("Status", style: textStyle),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(paymentMethod, style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text(orderId, style: textStyle),
            pw.SizedBox(height: 8),
            // Buttons are not supported in PDF like in Flutter. Use Text or another representation.
            pw.Text(status, style: textStyle),
          ],
        ),
      ],
    ),
  );
}

pw.Widget buildPaymentConfirmationTitle() {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Padding(
      padding: const pw.EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: pw.Text(
        "Payment Confirmation",
        style: pw.TextStyle(
          fontSize: 14, // Adjust the font size as needed
          fontWeight: pw.FontWeight.bold,
          // Add color if necessary
        ),
      ),
    ),
  );
}

pw.Widget buildPaymentSummary() {
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

  return pw.Padding(
    padding: const pw.EdgeInsets.all(10),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Coupon code", style: labelStyle),
            pw.Text("EventoR7", style: valueStyle),
          ],
        ),
        // ... Add other Rows here ...
        pw.Divider(thickness: 1),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Total", style: labelStyle),
            pw.Text("120,000 sp", style: valueStyle),
          ],
        ),
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

pw.Widget buildQrCodeSection() {
  return pw.Align(
    alignment: pw.Alignment.center,
    child: pw.Padding(
      padding: const pw.EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(),
        data: 'Barcode',
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

pw.Widget buildAttendeeInformation(TicketModel ticketModel) {
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
            pw.Text(
                "${ticketModel.fisrtName.text} ${ticketModel.lastName.text}",
                style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text(ticketModel.age.text, style: textStyle),
            pw.SizedBox(height: 8),
            pw.Text(ticketModel.phoneNumber.text, style: textStyle),
          ],
        ),
      ],
    ),
  );
}
