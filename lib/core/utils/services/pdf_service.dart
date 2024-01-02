import 'dart:io';

import 'package:evento/features/book_now/model/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}



Future<void> createTicketPDF(TicketModel ticketModel, int modelIndex) async {
  final pdf = pw.Document();
  // final qrImageBytes = await generateQRCodeImage('Your QR Code Data');

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return 
        pw.Container(
          height: 900, // Adjust the height as needed
          width: 500,
          child:pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text("Ticket ${modelIndex + 1}"),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Container(
                 padding: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 20),
       
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(16),
                border: pw.Border.all(),
              ),
              child: pw.Column(
                
                children: [
                  pw.BarcodeWidget(
                    barcode: pw.Barcode.qrCode(),
                    data: 'Your QR Code Data',
                    width: 200,
                    height: 200,
                  ),
                  pw.Text("Attendee Information"),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Full Name"),
                          pw.Text("Age"),
                          pw.Text("Phone Number"),
                        ],
                      ),
                      pw.Column(
                         crossAxisAlignment: pw.CrossAxisAlignment.end,
                       
                        children: [
                          pw.Text(
                              "${ticketModel.fisrtName.text} ${ticketModel.lastName.text}"),
                          pw.Text(ticketModel.age.text),
                          pw.Text(ticketModel.phoneNumber.text),
                        ],
                      ),
                    ],
                  ),
                  pw.Divider(),
                  pw.Text("Payment Summary"),
                  // Payment summary details
                  _buildPaymentSummaryRow("Coupon code", "EventoR7"),
                  _buildPaymentSummaryRow("Ticket", "100,000 sp"),
                  _buildPaymentSummaryRow("Tax", "20,000 sp"),
                  _buildPaymentSummaryRow("Discount", "20%"),
                  pw.Divider(),
                  _buildPaymentSummaryRow("Total", "120,000 sp"),
                  // More details based on your layout
                ],
              ),
            ),
          ),
        ],
      ));
    },
  ));
  List<int> bytes = await pdf.save();

  saveAndLaunchFile(bytes, 'Output.pdf');
}

pw.Widget _buildPaymentSummaryRow(String title, String value) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(title),
      pw.Text(value),
    ],
  );
}
