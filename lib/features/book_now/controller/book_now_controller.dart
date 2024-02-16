import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:evento/core/utils/helper/form_field_controller.dart';
import 'package:evento/features/book_now/model/promo_code_model.dart';
import '../../../core/server/helper_api.dart';
import '../../../core/server/server_config.dart';
import '../../../core/utils/error_handling/erroe_handling.dart';
import '../../../core/utils/helper/date_formatter.dart';
import '../model/ticket_model.dart';
import '../../events/event_detailes/controller/event_detailes_controller.dart';
import '../../events/event_detailes/model/event_detailes_model.dart';
import '../../profile_pages/freinds/model/freinds_model.dart';
import '../../../main.dart';
import 'package:get/get.dart';

class BookNowController extends GetxController {
  late EventDetailsModel eventDetailsModel;
  late RxBool isLoading;
  late RxBool isLoadingCoupons;
  late RxList<String> errorMessage;
  late RxList<FreindsModel> myFreinds;
  late RxList<TicketModel> ticketList;
  late List<PromoCode> userCopuns;
  @override
  void onInit() {
    EventDetailesController eventDetailesController = Get.find();
    eventDetailsModel = eventDetailesController.eventDetailsModel;
    ticketList = <TicketModel>[TicketModel(ticketIndex: 0)].obs;
    // print(ticketList[0].selectedClass!.ticketPrice);
    ticketList[0].totalPrice = eventDetailsModel.ticketPrice;
    // print(eventDetailsModel.classes[0].ticketPrice);
    myFreinds = <FreindsModel>[].obs;
    isLoadingCoupons = false.obs;
    getMyCoupons();
    userCopuns = [];
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    getMyFreinds();
    super.onInit();
  }

  addnewTicket() {
    ticketList.add(TicketModel(ticketIndex: ticketList.length));
    ticketList.last.totalPrice = eventDetailsModel.ticketPrice;
  }

  addOrRemoveAminitesFromCladd(Amenity title, int index) {
    int aminityPrice = 0;

    for (var element in eventDetailsModel.amenities) {
      if (element.id == title.id) {
        aminityPrice = element.pivot.price!;
        title.pivot.price != aminityPrice;
      }
    }
    if (ticketList[index].selectedAminiteds.contains(title)) {
      ticketList[index].selectedAminiteds.remove(title);

      ticketList[index].totalPrice -= aminityPrice;
    } else {
      ticketList[index].selectedAminiteds.add(title);
      ticketList[index].totalPrice += aminityPrice;
      title.pivot.price = aminityPrice;
    }
    update();
  }

  removeTicket(int ticketIndex) {
    ticketList.removeAt(ticketIndex);

    // userCopuns.map((e) {});
    update();
  }

  int calculateDiscountForTicket(int ticketIndex) {
    if (ticketList[ticketIndex].selectedPromoCode != null) {
      int codeDiscount =
          int.parse(ticketList[ticketIndex].selectedPromoCode!.discount);
      int codeLimit =
          int.parse(ticketList[ticketIndex].selectedPromoCode!.limit);
      int newTotal =
          ((ticketList[ticketIndex].totalPrice * codeDiscount) / 100).round();
      if (ticketList[ticketIndex].totalPrice - newTotal > codeLimit) {
        ticketList[ticketIndex].discount = codeLimit;
        return codeLimit;
      } else {
        ticketList[ticketIndex].discount = newTotal;
        return newTotal;
      }
    } else {
      return 0;
    }
  }

  removecopounFromticket(String couponCode, int ticketId) {
    ticketList[ticketId].dropDownValueController!.value = null;
    ticketList[ticketId].selectedPromoCode = null;

    print("removed succes");
    update();
  }

  getcopounFromCode(String copounCode) {
    for (var i = 0; i < userCopuns.length; i++) {
      if (userCopuns[i].code == copounCode) {
        // userCopuns[i].isSelected = false;
        // userCopuns[i].tiketId = -1;
        return userCopuns[i];
      }
    }
  }

  changeSelectedCouponInTicket(String couponCode, int ticketId) {
    for (var i = 0; i < userCopuns.length; i++) {
      /// get copun object
      if (userCopuns[i].code == couponCode) {
        ticketList[ticketId].selectedPromoCode = userCopuns[i];
        ticketList[ticketId].discount = int.tryParse(userCopuns[i].discount)!;

        ticketList[ticketId].dropDownValueController!.value = couponCode;
        break;
      }
    }

    update();
  }

  List<String> getCouponListForTicket(int ticketId) {
    // Log the ticketId being processed
    print('Processing ticketId: $ticketId');

    // Assuming `userCoupons` is a List<PromoCode> of all promo codes
    // And `ticketList` is a List<TicketModel>, where each TicketModel has an ID and an optional selected PromoCode

    // Create a list to keep track of codes that are already selected for other tickets
    List<String> selectedCodesForOtherTickets = [];

    // Identify the promo code selected for the current ticket, if any
    var selectedCodeForCurrentTicket = ticketList
        .firstWhereOrNull((ticket) => ticket.ticketIndex == ticketId)
        ?.selectedPromoCode
        ?.code;

    // Log the selected code for the current ticket
    print(
        'Selected code for current ticket ($ticketId): $selectedCodeForCurrentTicket');

    // Populate the list of selected codes for other tickets
    for (var ticket in ticketList) {
      if (ticket.ticketIndex != ticketId && ticket.selectedPromoCode != null) {
        selectedCodesForOtherTickets.add(ticket.selectedPromoCode!.code);
      }
    }

    // Log the codes selected for other tickets
    print('Selected codes for other tickets: $selectedCodesForOtherTickets');

    // Filter the userCoupons to exclude the codes that are selected for other tickets,
    // but include the code selected for the current ticket (if any)
    List<String> availableCouponCodes = userCopuns
        .where((promo) {
          bool isAvailable =
              !selectedCodesForOtherTickets.contains(promo.code) ||
                  promo.code == selectedCodeForCurrentTicket;
          // Log each promo code's availability
          print(
              'Checking promo code "${promo.code}": isAvailable = $isAvailable');
          return isAvailable;
        })
        .map((promo) => promo.code)
        .toList();

    // Log the final list of available coupon codes
    print('Available coupon codes for ticket $ticketId: $availableCouponCodes');

    return availableCouponCodes;
  }

  changeSelectedCalss(Class newClass, int index) {
    //// check if there no class selecte yet
    if (ticketList[index].selectedClass == null) {
      ticketList[index].totalPrice += newClass.ticketPrice;
      ticketList[index].selectedClass = newClass;
      ticketList[index].selectedAminiteds = [];
    } else {
      //// check if the selected class same the prev selected one unselected the current calss
      if (ticketList[index].selectedClass == newClass) {
        log("unselected calss");
        ticketList[index].selectedClass == null;
        ticketList[index].totalPrice -=
            ticketList[index].selectedClass!.ticketPrice;
        ticketList[index].selectedAminiteds = [];
      } else {
        /// then select new calss and selete the prev one data
        log("last else");
        ticketList[index].totalPrice -=
            ticketList[index].selectedClass!.ticketPrice;

        ticketList[index].totalPrice += newClass.ticketPrice;
        ticketList[index].selectedClass = newClass;
        ticketList[index].selectedAminiteds = [];
      }
    }
    update();
  }

  deCrementTicketCount() {
    if (ticketList.length > 1) {
      ticketList.removeLast();
    }
  }

  void onPressBookNow() async {
    isLoading.value = true;
    errorMessage = <String>[].obs;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.bookNow,
        method: "post",
        token: token,
        data: createBookingJson(ticketList));

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      whenBookingSuccefly(handlingResponse);
    }
    isLoading.value = false;
  }

  whenBookingSuccefly(handlingResponse) {
    handlingResponse['message'] == "Booking successful"
        ? Get.toNamed('/BookingDetailesScreen',
            arguments: [eventDetailsModel, ticketList])
        : null;
  }

  Map<String, dynamic> createBookingJson(List<TicketModel> bookings) {
    List<Map<String, dynamic>> bookingList = [];

    for (var booking in bookings) {
      if (booking.selectedClass == null) {
        bookingList.add({
          'first_name': booking.fisrtName.text,
          'last_name': booking.lastName.text,
          'age': int.tryParse(booking.age.text) ?? 0,
          'phone_number': booking.phoneNumber.text,
        });
      } else {
        bookingList.add({
          'class_id': booking.selectedClass!.id,
          'first_name': booking.fisrtName.text,
          'last_name': booking.lastName.text,
          'age': int.tryParse(booking.age.text) ?? 0,
          'phone_number': booking.phoneNumber.text,
          'options':
              booking.selectedAminiteds.map((a) => a.id.toString()).toList(),
        });
      }
    }

    Map<String, dynamic> jsonMap = {'bookings': bookingList};
    return jsonMap;
  }

  onPressFillMyData(int ticketIndex) {
    ticketList[ticketIndex].fisrtName.text = user!.firstName;
    ticketList[ticketIndex].lastName.text = user!.lastName;
    ticketList[ticketIndex].phoneNumber.text = user!.phoneNumber;
    ticketList[ticketIndex].age.text =
        calculateAge(DateTime.parse(user!.birthDate)).toString();
  }

  getMyCoupons() async {
    // isLoadingCoupons.value = true;
    print("start re");
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.myCoupons}/${eventDetailsModel.id}",
        method: "GEt",
        token: token);
    print("after re");
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    print(handlingResponse);
    if (handlingResponse is ErrorResponse) {
    } else {
      List<dynamic> interestsJson = handlingResponse['promoCode'];

      userCopuns = interestsJson
          .map((jsonItem) => PromoCode.fromJson(jsonItem))
          .toList();

      print("user copouns:$userCopuns");
      // userCopuns.removeLast();
    }
    isLoadingCoupons.value = false;
    // update();
  }

  getMyFreinds() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myFreinds, method: "GEt", token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
    } else {
      List<dynamic> interestsJson = handlingResponse['friends'];

      myFreinds.value = interestsJson
          .map((jsonItem) => FreindsModel.fromJson(jsonItem))
          .toList();
    }
    update();
  }
}
