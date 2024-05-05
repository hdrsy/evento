import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/booking/book_now/model/promo_code_model.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/model/booking_detailes_for_my_booking_model.dart';
import 'package:evento/features/events/home/model/offer_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

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
      // String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.getUserTicket + "/" + ticketId.toString(),
        method: "get",
      );

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        // isErrorCanceled.value = true;
        isError.value = true;
        isLoading.value = false;
        // errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        userBookings = UserBooking.fromJson(handlingResponse['ticket']);

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
    classp = userBookings.event.classes
        .where((element) => element.id == userBookings.classId)
        .first
        .ticketPrice;
    int offerD = 0;
    offerD = userBookings.offer == null
        ? 0
        : calclateofferDiscountForClass(
            userBookings.offer!,
            userBookings.event.classes
                .where((element) => element.id == userBookings.classId)
                .first
                .ticketPrice);
    int promoD = 0;
    promoD = userBookings.promoCode == null
        ? 0
        : calculateDiscountForTicket(userBookings.promoCode!, index);
    int total = classp - offerD - promoD;
    return total;
  }

  int calculateDiscountForTicket(PromoCode promoCode, int ticketIndex) {
    int totalAminityPrice = 0;
    int totalClassPrice = 0;
    int total = 0;

    totalClassPrice = userBookings.event.classes
        .where((element) => element.id == userBookings.classId)
        .first
        .ticketPrice;

    if (userBookings.offer != null) {
      totalClassPrice -=
          calclateofferDiscountForClass(userBookings.offer!, totalClassPrice);
    }
    for (var i = 0; i < userBookings.amenities.length; i++) {
      for (var element in userBookings.event.amenities) {
        if (element.id == userBookings.amenities[i].id) {
          totalAminityPrice += element.pivot.price!;
        }
      }
    }
    total = totalAminityPrice + totalClassPrice;
    int codeDiscount = (promoCode.discount);
    int codeLimit = (promoCode.limit);
    int newTotal = ((total * codeDiscount) / 100).round();
    if (total - newTotal > codeLimit) {
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
