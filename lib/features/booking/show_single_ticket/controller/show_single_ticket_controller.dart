import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/model/booking_detailes_for_my_booking_model.dart';
import 'package:evento/main.dart';

import '../../../../core/utils/services/pdf_service.dart';
import '../../book_now/model/ticket_model.dart';

class ShowSingleTicketController extends GetxController {
  List<TicketModel> generatedTicketModel = [];
  late UserBooking userBookings;
  late int eventId;
  late int ticketId;

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  @override
  void onInit() async {
    ticketId = int.parse(Get.parameters['id'] ?? "0");
    await getCalceledBooking();
    super.onInit();
  }

  createTicketModelsFromEventBookings(List<UserBooking> bookings) {
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

  getCalceledBooking() async {
    try {
      isLoading.value = true;
      isError.value = false;
      update();
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.getUserBooking,
          method: "post",
          token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        // isErrorCanceled.value = true;
        isError.value = true;
        isLoading.value = false;
        // errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        userBookings = UserBooking.fromJson(handlingResponse['bookings']);

        // isLoadingCancall.value = false;
        isLoading.value = false;
      }
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
    }
    // isErrorCanceled.value = true;
    update();
  }

  updateTotalPrice(int ticketIndex) {
    int total = 0;
    total = userBookings.classTicketPrice;

    for (int index = 0; index < userBookings.amenities.length; index++) {
      total += userBookings.event.amenities
          .where((element) => element.id == userBookings.amenities[index].id)
          .first
          .pivot
          .price!;
    }
    if (userBookings.promoCode != null) {}
    return total;
    // discount = ticketList.discount;
    // // tax = getTaxForTicket(ticketIndex);
    // total = (totalAminityPrice + totalClassPrice + tax) - discount;
    // ticketList.totalPrice = total;
  }

  void openPdf() async {
    createTicketPDF(createTicketModelsFromEventBookings([userBookings]),
        userBookings.event.title);
  }
}
