import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/up_coming_booking.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class CancelBookingController extends GetxController {
  late List<EventBooking> bookings;
  List<int> selectedTicket = [];
  String? selectedValue;
  late RxList<String> errorMessage;
  bool cancellState=false;
  @override
  void onInit() {
    // TODO: implement onInit
    errorMessage = <String>[].obs;
    super.onInit();
  }

  changeSelected(int id) {
    selectedTicket.contains(id)
        ? selectedTicket.remove(id)
        : selectedTicket.add(id);
    update();
  }

  onPressCancell() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    for (var i = 0; i < selectedTicket.length; i++) {
      print(selectedTicket[0]);
      print(selectedValue);
String token = await prefService.readString("token") ?? "";
    
      response = await ApiHelper.makeRequest(
          targetRout: "${ServerConstApis.cancellBooking}/${selectedTicket[i]}",
          method: "Post",
          token: token,
          data: {"reason": selectedValue!});
      print(response);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        print(errorMessage[0]);
        cancellState=false;
      } else {
        cancellState=true;
      }
    }
    
  }
}
