
import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/book_now/model/ticket_model.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/features/profile_pages/my_booking/model/my_cancel_booking_model.dart';
import 'package:evento/features/profile_pages/my_booking/model/up_coming_booking.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class MyBookingController extends GetxController{
  late List<CancelledBooking> cancelledBooking;
  late List<UpComingBooking> upComingBooking;
  late List<UpComingBooking> completedBooking;
  late RxList<String> errorMessage;
late RxBool isLoading;
List<TicketModel> generatedTicketModel=[];
   @override
  void onInit() async{
    errorMessage = <String>[].obs;
    cancelledBooking=[];
    upComingBooking=[];
    completedBooking=[];
    isLoading=false.obs;
  await  getUpComingAndCompletedBooking();
    await getCalceledBooking();
    // TODO: implement onInit
    super.onInit();
  }
   getCalceledBooking() async {
    isLoading.value=true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myCancelledBookings,
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['cancelled_bookings'];

      cancelledBooking = interestsJson
          .map((jsonItem) => CancelledBooking.fromJson(jsonItem))
          .toList();
      update();
    }
  }
   getUpComingAndCompletedBooking() async {
    isLoading.value=true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myBooking,
        method: "GEt",
        token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['bookings'];
      List<dynamic> completedJson = handlingResponse['completed_bookings'];

      upComingBooking = interestsJson
          .map((jsonItem) => UpComingBooking.fromJson(jsonItem))
          .toList();
      completedBooking = interestsJson
          .map((jsonItem) => UpComingBooking.fromJson(jsonItem))
          .toList();
          print(upComingBooking.length);
      update();
    }
  }

  List<TicketModel> createTicketModelsFromEventBookings(List<EventBooking> bookings) {
    generatedTicketModel.clear();
  
for (var i=0;i<bookings.length;i++) {
  generatedTicketModel.add(TicketModel());
  generatedTicketModel[i].age.text=bookings[i].age.toString();
  generatedTicketModel[i].fisrtName.text=bookings[i].firstName.toString();
  generatedTicketModel[i].lastName.text=bookings[i].lastName.toString();
  generatedTicketModel[i].phoneNumber.text=bookings[i].phoneNumber.toString();
}
print(generatedTicketModel.length);
  return generatedTicketModel;
}


}