import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/book_now/model/ticket_model.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class BookNowController extends GetxController {
  late EventDetailsModel eventDetailsModel;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  late RxList<TicketModel> ticketList;
  @override
  void onInit() {
    EventDetailesController eventDetailesController = Get.find();
    eventDetailsModel = eventDetailesController.eventDetailsModel;
    ticketList = <TicketModel>[
      TicketModel(selectedClass: eventDetailsModel.classes[0])
    ].obs;
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    super.onInit();
  }

  addOrRemoveAminitesFromCladd(Amenity title, int index) {
    ticketList[index].selectedAminiteds.contains(title)
        ? ticketList[index].selectedAminiteds.remove(title)
        : ticketList[index].selectedAminiteds.add(title);

    update();
  }

  changeSelectedCalss(Class newClass, int index) {
    ticketList[index].selectedClass = newClass;
    ticketList[index].selectedAminiteds = [];
    update();
  }

  inCrementTicketCount() {
    ticketList.add(TicketModel(selectedClass: eventDetailsModel.classes[0]));
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
    String token = await prefService.readString("token") ?? "";
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
        ? Get.toNamed('/BookingDetailesScreen',arguments: [eventDetailsModel,ticketList])
        : null;
  }

  Map<String, dynamic> createBookingJson(List<TicketModel> bookings) {
    List<Map<String, dynamic>> bookingList = [];

    for (var booking in bookings) {
      bookingList.add({
        'class_id': booking.selectedClass.id,
        'first_name': booking.fisrtName.text,
        'last_name': booking.lastName.text,
        'age': int.tryParse(booking.age.text) ?? 0,
        'phone_number': booking.phoneNumber.text,
        'options':
            booking.selectedAminiteds.map((a) => a.id.toString()).toList(),
      });
    }

    Map<String, dynamic> jsonMap = {'bookings': bookingList};
    return jsonMap;
  }
}
