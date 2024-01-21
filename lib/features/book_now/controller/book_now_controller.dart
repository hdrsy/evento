import 'package:dartz/dartz.dart';
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
  late RxList<String> errorMessage;
  late RxList<FreindsModel> myFreinds;

  late RxList<TicketModel> ticketList;
  @override
  void onInit() {
    EventDetailesController eventDetailesController = Get.find();
    eventDetailsModel = eventDetailesController.eventDetailsModel;
    ticketList = <TicketModel>[
      TicketModel(selectedClass: eventDetailsModel.classes[0])
    ].obs;
    print(ticketList[0].selectedClass!.ticketPrice);
    ticketList[0].totalPrice=eventDetailsModel.classes[0].ticketPrice;
    print(eventDetailsModel.classes[0].ticketPrice);
    myFreinds = <FreindsModel>[].obs;

    isLoading = false.obs;
    errorMessage = <String>[].obs;
    getMyFreinds();
    super.onInit();
  }
 getAminityPrice(Amenity title){

}
  addOrRemoveAminitesFromCladd(Amenity title, int index) {
    int aminityPrice = 0;
    
    for (var element in eventDetailsModel.amenities) {
      if (element.id==title.id
         ) {
        aminityPrice = element.price!;
        title.price!=aminityPrice;
       
      }
    }
    if (ticketList[index].selectedAminiteds.contains(title)) {
      ticketList[index].selectedAminiteds.remove(title);

      ticketList[index].totalPrice -= aminityPrice;
    } else {
      ticketList[index].selectedAminiteds.add(title);
      ticketList[index].totalPrice += aminityPrice;
    title.price=aminityPrice;

    }
    update();
  }

  changeSelectedCalss(Class newClass, int index) {
    ticketList[index].selectedClass = newClass;
    ticketList[index].totalPrice=newClass.ticketPrice;
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
        ? Get.toNamed('/BookingDetailesScreen',
            arguments: [eventDetailsModel, ticketList])
        : null;
  }

  Map<String, dynamic> createBookingJson(List<TicketModel> bookings) {
    List<Map<String, dynamic>> bookingList = [];

    for (var booking in bookings) {
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

  getMyFreinds() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myFreinds, method: "GEt", token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
    } else {
      List<dynamic> interestsJson = handlingResponse['friends'];

      myFreinds.value = interestsJson
          .map((jsonItem) => FreindsModel.fromJson(jsonItem))
          .toList();
      print(myFreinds.length);
    }
    update();
  }
}
