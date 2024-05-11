import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/booking/book_now/model/promo_code_model.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/model/booking_detailes_for_my_booking_model.dart';
import 'package:evento/features/events/home/model/offer_model.dart';
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
  RxBool isError = false.obs;
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
    try {
      isLoading.value = true;
      isError.value = false;
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
        isError.value = true;
        isLoading.value = false;
        // errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        List<dynamic> interestsJson = handlingResponse['bookings'];
        userBookings = interestsJson
            .map((jsonItem) => UserBooking.fromJson(jsonItem))
            .toList();
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

  calclatepiceaftediscount(int index) {
    int classp = 0;
    classp = userBookings[index]
        .event
        .classes
        .where((element) => element.id == userBookings[index].classId)
        .first
        .ticketPrice;
    int offerD = 0;
    offerD = userBookings[index].offer == null
        ? 0
        : calclateofferDiscountForClass(
            userBookings[index].offer!,
            userBookings[index]
                .event
                .classes
                .where((element) => element.id == userBookings[index].classId)
                .first
                .ticketPrice);
    int promoD = 0;
    promoD = userBookings[index].promoCode == null
        ? 0
        : calculateDiscountForTicket(userBookings[index].promoCode!, index);
    int total = classp - offerD - promoD;
    return total;
  }

  int calculateDiscountForTicket(PromoCode promoCode, int ticketIndex) {
    int totalAminityPrice = 0;
    int totalClassPrice = 0;
    int total = 0;

    totalClassPrice = userBookings[ticketIndex]
        .event
        .classes
        .where((element) => element.id == userBookings[ticketIndex].classId)
        .first
        .ticketPrice;

    if (userBookings[ticketIndex].offer != null) {
      totalClassPrice -= calclateofferDiscountForClass(
          userBookings[ticketIndex].offer!, totalClassPrice);
    }
    for (var i = 0; i < userBookings[ticketIndex].amenities.length; i++) {
      for (var element in userBookings[ticketIndex].event.amenities) {
        if (element.id == userBookings[ticketIndex].amenities[i].id) {
          totalAminityPrice += element.pivot.price!;
        }
      }
    }
    total = totalAminityPrice + totalClassPrice;
    int codeDiscount = (promoCode.discount);
    int codeLimit = (promoCode.limit);
    int newTotal = ((total * codeDiscount) / 100).round();
    if (newTotal > codeLimit) {
      return codeLimit;
    } else {
      return newTotal;
    }
  }

  int calclateofferDiscountForClass(Offer offer, int classPrice) {
    int offerPercent = offer.percent;
    return (classPrice * offerPercent ~/ 100);
  }

  updateTotalPrice(int ticketIndex) {
    int totalAminityPrice = 0;
    int totalClassPrice = 0;
    int discount = 0;
    int tax = 0;
    int total = 0;
    if (userBookings[ticketIndex]
            .event
            .classes
            .where((element) => element.id == userBookings[ticketIndex].classId)
            .first
            .ticketPrice !=
        null) {
      totalClassPrice = userBookings[ticketIndex]
          .event
          .classes
          .where((element) => element.id == userBookings[ticketIndex].classId)
          .first
          .ticketPrice;
    }
    if (userBookings[ticketIndex].offer != null) {
      totalClassPrice -= calclateofferDiscountForClass(
          userBookings[ticketIndex].offer!, totalClassPrice);
    }

    for (var i = 0; i < userBookings[ticketIndex].amenities.length; i++) {
      totalAminityPrice += userBookings[ticketIndex]
          .event
          .amenities
          .where((element) =>
              element.id == userBookings[ticketIndex].amenities[i].id)
          .first
          .pivot
          .price!;
      // for (var element in userBookings[ticketIndex].amenities) {
      //   if (element.id == ticketList[ticketIndex].selectedAminiteds[i].id) {}
      // }
    }
    if (userBookings[ticketIndex].promoCode != null) {
      // discount = ticketList[ticketIndex].discount;
      discount = calculateDiscountForTicket(
          userBookings[ticketIndex].promoCode!, ticketIndex);
    }
    // tax = getTaxForTicket(ticketIndex);
    total = (totalAminityPrice + totalClassPrice + tax) - discount;
    return total;
  }

  updateTotalPrice2(int ticketIndex) {
    int total = 0;
    total = userBookings[ticketIndex].classTicketPrice;

    for (int index = 0;
        index < userBookings[ticketIndex].amenities.length;
        index++) {
      total += userBookings[ticketIndex]
          .event
          .amenities
          .where((element) =>
              element.id == userBookings[ticketIndex].amenities[index].id)
          .first
          .pivot
          .price!;
    }
    if (userBookings[ticketIndex].promoCode != null) {}
    return total;
    // discount = ticketList[ticketIndex].discount;
    // // tax = getTaxForTicket(ticketIndex);
    // total = (totalAminityPrice + totalClassPrice + tax) - discount;
    // ticketList[ticketIndex].totalPrice = total;
  }

  void openPdf() async {
    createTicketPDF(userBookings, userBookings[0].event.title);
  }
}
