import 'dart:io';

import 'package:evento/features/profile_pages/my_booking/model/my_cancel_booking_model.dart';

import '../../../core/utils/services/pdf_service.dart';
import '../../book_now/model/ticket_model.dart';
import '../../events/event_detailes/model/event_detailes_model.dart';
import 'package:get/get.dart';
    import 'package:open_file/open_file.dart';

class BookingDetailesForMyBookingController extends GetxController{
  late List<TicketModel> ticketList;
   late CancelledEvent eventDetailsModel;
 
@override
  void onInit() {
    eventDetailsModel=Get.arguments[0];
    ticketList=Get.arguments[1];
    super.onInit();
  }



void openPdf() async {
createTicketPDF(ticketList,eventDetailsModel.title);
}

  
}