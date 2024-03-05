import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../booking/book_now/model/ticket_model.dart';
import '../model/my_cancel_booking_model.dart';
import '../model/up_coming_booking.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class MyBookingController extends GetxController {
  late List<CancelledBooking> cancelledBooking;
  late List<BookingResponse> upComingBooking;
  late List<BookingResponse> completedBooking;
  late RxList<String> errorMessage;
  late RxBool isLoading;
  RxBool isErrorUpComing = false.obs;
  RxBool isErrorCanceled = false.obs;
  List<TicketModel> generatedTicketModel = [];
  @override
  void onInit() async {
    errorMessage = <String>[].obs;
    cancelledBooking = [];
    upComingBooking = [];
    completedBooking = [];
    isLoading = false.obs;
    await getUpComingAndCompletedBooking();
    await getCalceledBooking();
    super.onInit();
  }

  getCalceledBooking() async {
    try {
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.myCancelledBookings,
          method: "GEt",
          token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        isErrorCanceled.value = true;
        errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        List<dynamic> interestsJson = handlingResponse['cancelled_bookings'];

        cancelledBooking = interestsJson
            .map((jsonItem) => CancelledBooking.fromJson(jsonItem))
            .toList();
        isLoading.value = false;
        update();
      }
    } catch (e) {
      isLoading.value = false;
      isErrorCanceled.value = true;
    }
  }

  getUpComingAndCompletedBooking() async {
    // try {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myBooking, method: "GEt", token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      isErrorUpComing.value = true;
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      upComingBooking = (handlingResponse['upcomingBookings'] as List)
          .map((jsonItem) => BookingResponse.fromJson(jsonItem))
          .toList();
      completedBooking = (handlingResponse['completedBookings'] as List)
          .map((jsonItem) => BookingResponse.fromJson(jsonItem))
          .toList();

      isLoading.value = false;
      update();
    }
    // } catch (e) {
    //   isLoading.value = false;
    //   isErrorUpComing.value = true;
    // }
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
}
