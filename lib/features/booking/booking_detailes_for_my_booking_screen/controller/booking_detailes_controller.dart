import 'package:evento/features/booking/my_booking/model/up_coming_booking.dart';

import '../../../../core/utils/services/pdf_service.dart';
import '../../book_now/model/ticket_model.dart';
import 'package:get/get.dart';

class BookingDetailesForMyBookingController extends GetxController {
  late List<TicketModel> ticketList;
  late Event eventDetailsModel;

  @override
  void onInit() {
    eventDetailsModel = Get.arguments[0];
    ticketList = Get.arguments[1];
    super.onInit();
  }

  void openPdf() async {
    createTicketPDF(ticketList, eventDetailsModel.title);
  }
}
