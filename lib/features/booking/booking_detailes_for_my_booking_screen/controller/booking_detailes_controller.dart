import 'package:evento/features/booking/my_booking/model/up_coming_booking.dart';

import '../../../../core/utils/services/pdf_service.dart';
import '../../book_now/model/ticket_model.dart';
import 'package:get/get.dart';

class BookingDetailesForMyBookingController extends GetxController {
  late BookingResponse ticketList;
  late Event eventDetailsModel;
  List<TicketModel> generatedTicketModel = [];

  @override
  void onInit() {
    eventDetailsModel = Get.arguments[0];
    ticketList = Get.arguments[1];
    super.onInit();
  }

  createTicketModelsFromEventBookings(List<Booking> bookings) {
    generatedTicketModel.clear();

    for (var i = 0; i < bookings.length; i++) {
      generatedTicketModel.add(TicketModel());
      generatedTicketModel[i].age.text = bookings[i].age.toString();
      generatedTicketModel[i].fisrtName.text = bookings[i].firstName.toString();
      generatedTicketModel[i].lastName.text = bookings[i].lastName.toString();
      generatedTicketModel[i].phoneNumber.text =
          bookings[i].phoneNumber.toString();
    }
    return generatedTicketModel;
  }

  void openPdf() async {
    createTicketPDF(
        createTicketModelsFromEventBookings(ticketList.upcomingBookings),
        eventDetailsModel.title);
  }
}
