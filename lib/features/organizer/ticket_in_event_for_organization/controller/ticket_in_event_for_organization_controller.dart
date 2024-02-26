import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/book_now/model/ticket_model.dart';
import 'package:evento/features/organizer/organization_profile/model/organizer_profile_model.dart';
import 'package:evento/features/organizer/ticket_in_event_for_organization/model/ticket_in_event_for_organization_model.dart';
import 'package:evento/features/profile_pages/my_booking/model/my_cancel_booking_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class TicketsInEventForOrganizerController extends GetxController {
  BookingResponse bookingResponse = BookingResponse(booking: {});
  late OrganizationProfileEvent organizationProfileEvent;
  late int eventId;
  List<TicketModel> generatedTicketModel = [];
  late CancelledEvent eventDetailsModel;

  late RxBool isLoading;
  RxBool isError = false.obs;
  @override
  void onInit() {
    eventId = Get.arguments[0];
    organizationProfileEvent = Get.arguments[1];
    isLoading = false.obs;
    getOrganizerFollowers();
    super.onInit();
  }

  createTicketModelsFromEventBookings(List<BookingO> bookings) {
    generatedTicketModel.clear();

    for (var i = 0; i < bookings.length; i++) {
      generatedTicketModel.add(TicketModel());
      generatedTicketModel[i].age.text = bookings[i].age.toString();
      generatedTicketModel[i].fisrtName.text = bookings[i].firstName.toString();
      generatedTicketModel[i].lastName.text = bookings[i].lastName.toString();
      generatedTicketModel[i].phoneNumber.text =
          bookings[i].phoneNumber.toString();
    }
    eventDetailsModel = CancelledEvent(
        id: eventId,
        title: organizationProfileEvent.title,
        startDate: organizationProfileEvent.startDate,
        endDate: DateTime.now(),
        venueId: organizationProfileEvent.venueId,
        images: [],
        isFollowedByAuthUser: false,
        venue: CancelledVenue(
            governorate: "Damascus", id: 1, locationDescription: ""));
    return generatedTicketModel;
  }

  getOrganizerFollowers() async {
    try {
      isLoading.value = true;
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout:
              "${ServerConstApis.organizationMyEventsBookings}/${eventId}",
          method: "GEt",
          token: token);

      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      print(handlingResponse);
      if (handlingResponse is ErrorResponse) {
        isError.value = true;
      } else {
        bookingResponse = BookingResponse.fromJson(handlingResponse);

        print("booking detailes:${bookingResponse.booking}");
        update();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }
  }
}
