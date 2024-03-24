import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/payment_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/error_messages/error_messages.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/booking/book_now/controller/book_now_controller.dart';
import 'package:evento/features/booking/book_now/model/ticket_model.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  @override
  void onClose() {
    if (paidSccuffly) {
      final BookNowController bookNowController = Get.find();
      bookNowController.ticketList[ticketIndex].isPaidSuccfully.value = true;
    }
    // TODO: implement onClose
    super.onClose();
  }

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

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  RxBool isIvoiceCreated = false.obs;
  RxBool isPhoneCorrect = false.obs;
  bool paidSccuffly = false;
  RxBool isSentOtpActive = false.obs;
  RxBool isLoadingPhone = false.obs;
  RxBool isLoadingotp = false.obs;
  RxString errorMessageInInvoice = "".obs;
  late Map<String, dynamic> booking;
  late List<TicketModel> ticketList;
  late EventDetailsModel eventDetailsModel;
  int totalAmount = 0;
  int invoiceTax = 0;
  RxInt invoiceId = 0.obs;
  List bookingIds = [];
  int ticketIndex = 0;

  @override
  void onInit() {
    _totalSeconds = 360.obs;
    _isRunning = false.obs;
    _hours = 00.obs;
    _minutes = 6.obs;
    _seconds = 00.obs;

    eventDetailsModel = Get.arguments[0];
    ticketList = Get.arguments[1];
    booking = Get.arguments[2];
    ticketIndex = Get.arguments[3];
    invoiceTax = Get.arguments[5];
    totalAmount = Get.arguments[4];
    // getTaxInvoice(totalAmount);
    super.onInit();
  }

  void getInvoice() async {
    isIvoiceCreated.value = false;
    otp.clear();
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();

      isLoadingPhone.value = true;
      errorMessageInInvoice.value = '';
      Map<String, dynamic> data = {
        "customer_phone": phone.text.startsWith("0", 0)
            ? "963${phone.text.substring(1)}"
            : "963${phone.text}",
        "event_id": eventDetailsModel.id,
      };
      booking.forEach((key, value) {
        data[key] = value;
      });
      Either<String, Map> response;
      String token = await prefService.readString("token");
      response = await PaymentApi.makeRequest(
          targetRout: ServerConstApis.getInvoice,
          method: "post",
          token: token,
          data: data);
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is String) {
        errorMessageInInvoice.value = handlingResponse;
        // errorMessage.value = handlingResponse.getErrorMessages();
      } else {
        isIvoiceCreated.value = true;
        startTimer();
        invoiceId.value = handlingResponse['0']['Receipt']['Invoice'];
        bookingIds = handlingResponse["1"];
      }
      isLoadingPhone.value = false;
    }
  }

  sentOtp() async {
    isLoadingotp.value = true;
    Map<String, dynamic> data = {
      // "invoice_amount": calculateIvoiceAmount(),
      "invoice_id": invoiceId.value,
      "customer_phone": phone.text.startsWith("0", 0)
          ? "963${phone.text.substring(1)}"
          : "963${phone.text}",
      "code": otp.text,
      "ids": bookingIds,
      "event_id": eventDetailsModel.id
    };
    if (booking.containsKey('promo_code_id')) {
      data['promo_code_id'] = booking['promo_code_id'];
    }

    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token");
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.confirmPayment,
        method: "post",
        token: token,
        data: data);
    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      isIvoiceCreated.value = false;
      errorMessageInInvoice.value = handlingResponse.getErrorMessages()[0];
      _totalSeconds = 360.obs;
      _isRunning = false.obs;
      _hours = 00.obs;
      _minutes = 6.obs;
      _seconds = 00.obs;
      timer!.cancel();
      otp.clear();

      Get.dialog(AlertDialog(
          backgroundColor: customColors.secondaryBackground,
          title: Text("error_message",
                  style: customTextStyle.titleSmall
                      .copyWith(color: customColors.primaryText))
              .tr(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ErrorMessages(
                message: "reason_information_entered",
              ),
              ErrorMessages(
                message: "reason_insufficient_balance",
              ),
              ErrorMessages(
                message: "reason_no_internet",
              )
            ],
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "Ok",
                  style: customTextStyle.titleSmall.override(
                    fontFamily: 'Nunito',
                    color: customColors.primaryText,
                    fontSize: 14.sp,
                    useGoogleFonts: true,
                  ),
                ).tr())
          ]));
    } else {
      paidSccuffly = true;
      Get.offAndToNamed('/BookingDetailesForMyBookingScreen',
          arguments: [eventDetailsModel.id, user!.id]);
    }
    isLoadingotp.value = false;
  }

  int calculateIvoiceAmount() {
    int amount = 0;
    for (var i = 0; i < ticketList.length; i++) {
      amount += (ticketList[i].totalPrice - ticketList[i].tax);
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
          isSentOtpActive.value = false;
          timer!.cancel();
        }
      });
    }
  }

  reSet() {
    isIvoiceCreated.value = false;
    _totalSeconds = 360.obs;
    _isRunning = false.obs;
    _hours = 00.obs;
    _minutes = 6.obs;
    _seconds = 00.obs;
    timer!.cancel();
    otp.clear();
  }
}
