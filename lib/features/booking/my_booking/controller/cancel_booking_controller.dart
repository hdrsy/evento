import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../model/up_coming_booking.dart';
import '../../../../main.dart';
import 'package:get/get.dart';

class CancelBookingController extends GetxController {
  RxList<int> selectedTicket = <int>[].obs;
  List<int> invoiceTicket = [];
  String? selectedValue;
  late RxList<String> errorMessage;
  bool cancellState = false;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    errorMessage = <String>[].obs;
    super.onInit();
  }

  changeSelected(int id, Booking booking) {
    print("the invoice is:${booking.invoiceId}");
    if (selectedTicket.contains(id)) {
      selectedTicket.remove(id);
      invoiceTicket.remove(booking.invoiceId);
    } else {
      selectedTicket.add(id);
      invoiceTicket.add(booking.invoiceId);
    }

    print("the invoice length:${invoiceTicket.length}");
    update();
  }

  onPressCancell() async {
    isLoading.value = true;
    Either<ErrorResponse, Map<String, dynamic>> response;
    for (var i = 0; i < selectedTicket.length; i++) {
      String token = await prefService.readString("token");
      print("the invoice is:${invoiceTicket[i]}");
      response = await ApiHelper.makeRequest(
          targetRout: "${ServerConstApis.cancellBooking}",
          method: "Post",
          token: token,
          data: {"reason": selectedValue!, "invoice_id": invoiceTicket[i]});

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      if (handlingResponse is ErrorResponse) {
        errorMessage.value = handlingResponse.getErrorMessages();
        cancellState = false;
      } else {
        cancellState = true;
      }
    }
    isLoading.value = false;
  }
}
