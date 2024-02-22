import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/book_now/model/ticket_model.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();
  late RxInt _totalSeconds;
  late RxBool _isRunning;
  late RxInt _hours;
  late RxInt _minutes;
  late RxInt _seconds;
  int get hours => _hours.value;
  int get minutes => _minutes.value;
  int get seconds => _seconds.value;
  bool get isRunning => _isRunning.value;
  Timer? timer;

  RxBool isIvoiceCreated = false.obs;
  RxBool isPhoneCorrect = false.obs;
  RxBool isLoadingPhone = false.obs;
  RxList<String> errorMessage = <String>[].obs;
  late Map<String, dynamic> booking;
  late List<TicketModel> ticketList;
  late EventDetailsModel eventDetailsModel;

  @override
  void onInit() {
    _totalSeconds = 60.obs;
    _isRunning = false.obs;
    _hours = 00.obs;
    _minutes = 1.obs;
    _seconds = 00.obs;

    eventDetailsModel = Get.arguments[0];
    ticketList = Get.arguments[1];
    booking = Get.arguments[2];
    // TODO: implement onInit
    super.onInit();
  }

  void getInvoice() async {
    isLoadingPhone.value = true;
    errorMessage = <String>[].obs;
    print(booking['bookings']);
    Map<String, dynamic> data = {
      "invoice_amount": calculateIvoiceAmount(),
      "customer_phone": phone.text,
      "bookings": booking['bookings']
    };
    print(data);
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.getInvoice,
        method: "post",
        token: token,
        data: data);
    print("response for invoice is:$response");
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      isIvoiceCreated.value = true;
      // whenBookingSuccefly(handlingResponse);
    }
    isLoadingPhone.value = false;
  }

  int calculateIvoiceAmount() {
    int amount = 0;
    for (var i = 0; i < ticketList.length; i++) {
      amount += ticketList[i].totalPrice;
    }
    return amount;
  }

  void updateTimerDisplay() {
    _hours.value = _totalSeconds.value ~/ 3600;
    _minutes.value = (_totalSeconds.value ~/ 60) % 60;
    _seconds.value = _totalSeconds.value % 60;
  }

  startTimer() {
    if (!_isRunning.value) {
      _isRunning.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_totalSeconds > 0) {
          _totalSeconds.value--;
          updateTimerDisplay();
        } else {
          timer!.cancel();
        }
      });
    }
  }
}
