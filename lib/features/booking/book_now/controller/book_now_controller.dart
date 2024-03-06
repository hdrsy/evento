import 'package:dartz/dartz.dart';
import 'package:evento/features/booking/book_now/model/promo_code_model.dart';
import 'package:evento/features/friends/freinds/model/freinds_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/helper/date_formatter.dart';
import '../model/ticket_model.dart';
import '../../../events/event_detailes/controller/event_detailes_controller.dart';
import '../../../events/event_detailes/model/event_detailes_model.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class BookNowController extends GetxController {
  late EventDetailsModel eventDetailsModel;
  late RxBool isLoading;
  late RxBool isLoadingCoupons;
  late RxList<String> errorMessage;
  late RxList<FreindsModel> myFreinds;
  late RxList<TicketModel> ticketList;
  late List<PromoCode> userCopuns;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    EventDetailesController eventDetailesController = Get.find();
    eventDetailsModel = eventDetailesController.eventDetailsModel;
    ticketList = <TicketModel>[TicketModel(ticketIndex: 0)].obs;
    ticketList[0].selectedClass = eventDetailsModel.classes[0];

    updateTotalPrice(0);
    myFreinds = <FreindsModel>[].obs;
    isLoadingCoupons = false.obs;
    getMyCoupons();
    userCopuns = [];
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    getMyFreinds();
    super.onInit();
  }

  getTaxForTicket(int ticketId) {
    int totalPriceInTicket = ticketList[ticketId].totalPrice;
    if (totalPriceInTicket < 1000) {
      ticketList[ticketId].tax = 75;
    } else if (totalPriceInTicket > 1000 && totalPriceInTicket < 10000) {
      ticketList[ticketId].tax = 100;
    }
    if (totalPriceInTicket >= 10000 && totalPriceInTicket < 20000) {
      ticketList[ticketId].tax = 150;
    } else {
      ticketList[ticketId].tax = 200;
    }

    return ticketList[ticketId].tax;
    // update();
  }

  addnewTicket() {
    ticketList.add(TicketModel(ticketIndex: ticketList.length));
    ticketList.last.selectedClass = eventDetailsModel.classes[0];
    updateTotalPrice(ticketList.length - 1);
  }

  updateTotalPrice(int ticketIndex) {
    int totalAminityPrice = 0;
    int totalClassPrice = 0;
    int discount = 0;
    int tax = 0;
    int total = 0;
    if (ticketList[ticketIndex].selectedClass != null) {
      totalClassPrice = ticketList[ticketIndex].selectedClass!.ticketPrice;
    }
    for (var i = 0; i < ticketList[ticketIndex].selectedAminiteds.length; i++) {
      for (var element in eventDetailsModel.amenities) {
        if (element.id == ticketList[ticketIndex].selectedAminiteds[i].id) {
          totalAminityPrice += element.pivot.price!;
        }
      }
    }
    discount = ticketList[ticketIndex].discount;
    // tax = getTaxForTicket(ticketIndex);
    total = (totalAminityPrice + totalClassPrice + tax) - discount;
    ticketList[ticketIndex].totalPrice = total;
    update();
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
    } else {
      ticketList[index].selectedAminiteds.add(title);
      title.pivot.price = aminityPrice;
    }
    updateTotalPrice(index);
    update();
  }

  removeTicket(int ticketIndex) {
    ticketList.removeAt(ticketIndex);

    // userCopuns.map((e) {});
    update();
  }

  int calculateDiscountForTicket(int ticketIndex) {
    if (ticketList[ticketIndex].selectedPromoCode != null) {
      int codeDiscount = (ticketList[ticketIndex].selectedPromoCode!.discount);
      int codeLimit = (ticketList[ticketIndex].selectedPromoCode!.limit);
      int newTotal =
          ((ticketList[ticketIndex].totalPrice * codeDiscount) / 100).round();
      if (ticketList[ticketIndex].totalPrice - newTotal > codeLimit) {
        ticketList[ticketIndex].discount = codeLimit;
        return codeLimit;
      } else {
        ticketList[ticketIndex].discount =
            ticketList[ticketIndex].totalPrice - newTotal;
        return newTotal;
      }
    } else {
      return 0;
    }
  }

  removecopounFromticket(String couponCode, int ticketId) {
    ticketList[ticketId].dropDownValueController!.value = null;
    ticketList[ticketId].selectedPromoCode = null;
    ticketList[ticketId].discount = 0;

    updateTotalPrice(ticketId);
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
        ticketList[ticketId].discount = calculateDiscountForTicket(ticketId);
        ticketList[ticketId].dropDownValueController!.value = couponCode;
        break;
      }
    }
    updateTotalPrice(ticketId);
    update();
  }

  List<String> getCouponListForTicket(int ticketId) {
    // Assuming `userCoupons` is a List<PromoCode> of all promo codes
    // And `ticketList` is a List<TicketModel>, where each TicketModel has an ID and an optional selected PromoCode

    // Create a list to keep track of codes that are already selected for other tickets
    List<String> selectedCodesForOtherTickets = [];

    // Identify the promo code selected for the current ticket, if any
    var selectedCodeForCurrentTicket = ticketList
        .firstWhereOrNull((ticket) => ticket.ticketIndex == ticketId)
        ?.selectedPromoCode
        ?.code;

    // Populate the list of selected codes for other tickets
    for (var ticket in ticketList) {
      if (ticket.ticketIndex != ticketId && ticket.selectedPromoCode != null) {
        selectedCodesForOtherTickets.add(ticket.selectedPromoCode!.code);
      }
    }

    // Filter the userCoupons to exclude the codes that are selected for other tickets,
    // but include the code selected for the current ticket (if any)
    List<String> availableCouponCodes = userCopuns
        .where((promo) {
          bool isAvailable =
              !selectedCodesForOtherTickets.contains(promo.code) ||
                  promo.code == selectedCodeForCurrentTicket;
          return isAvailable;
        })
        .map((promo) => promo.code)
        .toList();

    return availableCouponCodes;
  }

  changeSelectedCalss(Class newClass, int index) {
    print("the selected class is :${newClass.interests.length}");
    //// check if there no class selecte yet
    if (ticketList[index].selectedClass == null) {
      ticketList[index].selectedClass = newClass;
      ticketList[index].selectedAminiteds = [];
    } else {
      //// check if the selected class same the prev selected one unselected the current calss
      if (ticketList[index].selectedClass == newClass) {
        ticketList[index].selectedClass == null;
        ticketList[index].selectedAminiteds = [];
      } else {
        /// then select new calss and selete the prev one data
        ticketList[index].selectedClass = newClass;
        ticketList[index].selectedAminiteds = [];
      }
    }
    updateTotalPrice(index);
    update();
  }

  deCrementTicketCount() {
    if (ticketList.length > 1) {
      ticketList.removeLast();
    }
  }

  void onPressBookNow() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      // Get.toNamed('/PaymentScreenInBooking', arguments: [
      //   eventDetailsModel,
      //   ticketList,
      //   createBookingJson(ticketList)
      // ]);
      errorMessage = <String>[].obs;
      isLoading.value = true;

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
        Future.delayed(const Duration(milliseconds: 500))
            .then((value) => scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.easeInOut,
                ));
      } else {
        whenBookingSuccefly(handlingResponse);
      }
      isLoading.value = false;
    }
  }

  whenBookingSuccefly(handlingResponse) {
    handlingResponse['message'] == "Booking successful"
        ? Get.toNamed('/PaymentScreenInBooking', arguments: [
            eventDetailsModel,
            ticketList,
            createBookingJson(ticketList)
          ])
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
          "class_ticket_price": booking.selectedClass!.ticketPrice,
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
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: "${ServerConstApis.myCoupons}/${eventDetailsModel.id}",
        method: "GEt",
        token: token);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
    } else {
      List<dynamic> interestsJson = handlingResponse['promoCode'];

      userCopuns = interestsJson
          .map((jsonItem) => PromoCode.fromJson(jsonItem))
          .toList();
    }
    isLoadingCoupons.value = false;
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
