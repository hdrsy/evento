import 'dart:io';

import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/model/booking_detailes_for_my_booking_model.dart';

import 'ticket_pdf_layout.dart';
import '../../../features/booking/book_now/model/ticket_model.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:external_path/external_path.dart';

import 'package:pdf/widgets.dart' as pw;

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}

Future<void> createTicketPDF(
    List<UserBooking> tickets, String eventTitle) async {
  final pdf = pw.Document();

  for (int i = 0; i < tickets.length; i++) {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return buildTicketCard(tickets[i], i);
        },
      ),
    );
  }

  List<int> bytes = await pdf.save();

  // saveAndLaunchFile(bytes, 'Output.pdf');
  saveAndOpenFile(bytes, "$eventTitle tickets.pdf");
}

Future<void> saveAndOpenFile(List<int> bytes, String filename) async {
  String path;

  if (Platform.isAndroid) {
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
    } else {
      // Handle permission denied
      return;
    }
  } else if (Platform.isIOS) {
    final directory = await getApplicationDocumentsDirectory();
    path = directory.path;
  } else {
    // Handle other platforms (optional)
    return;
  }

  final file = File('$path/$filename');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(file.path);
}
