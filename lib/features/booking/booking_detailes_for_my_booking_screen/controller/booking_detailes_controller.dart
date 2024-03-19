import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/model/booking_detailes_for_my_booking_model.dart';
import 'package:evento/features/booking/my_booking/model/up_coming_booking.dart';
import 'package:evento/main.dart';

import '../../../../core/utils/services/pdf_service.dart';
import '../../book_now/model/ticket_model.dart';
import 'package:get/get.dart';

class BookingDetailesForMyBookingController extends GetxController {
  List<TicketModel> generatedTicketModel = [];
  List<UserBooking> userBookings = [];
  late int eventId;
  late int userId;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    eventId = Get.arguments[0];
    userId = Get.arguments[1];
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
    // try {
    isLoading.value = true;
    update();
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.getUserBooking,
        method: "post",
        data: {"event_id": eventId, "user_id": userId},
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      // isErrorCanceled.value = true;
      // errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['bookings'];

      userBookings = interestsJson
          .map((jsonItem) => UserBooking.fromJson(jsonItem))
          .toList();
      // isLoadingCancall.value = false;
    }
    // } catch (e) {
    // }
    // isErrorCanceled.value = true;
    update();
    isLoading.value = false;
  }

  void openPdf() async {
    createTicketPDF(createTicketModelsFromEventBookings(userBookings),
        userBookings[0].event.title);
  }
}
