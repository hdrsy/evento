import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/booking/book_now/model/ticket_model.dart';
import 'package:evento/features/booking/my_booking/model/up_coming_booking.dart';
import 'package:evento/features/organizer/organization_profile/model/organizer_profile_model.dart';
import 'package:evento/features/organizer/ticket_in_event_for_organization/model/ticket_in_event_for_organization_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class TicketsInEventForOrganizerController extends GetxController {
  BookingResponseForOrganizer bookingResponse =
      BookingResponseForOrganizer(booking: {});
  late OrganizationProfileEvent organizationProfileEvent;
  late int eventId;
  BookingResponse generatedTicketModel = BookingResponse(upcomingBookings: []);
  late Event eventDetailsModel;

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
    generatedTicketModel.upcomingBookings = [];

    for (var i = 0; i < bookings.length; i++) {
      generatedTicketModel.upcomingBookings.add(Booking(
          age: bookings[i].age,
          amenities: [],
          classType: "",
          event: Event(
              capacity: 0,
              description: "",
              organizerId: 0,
              id: eventId,
              ticketPrice: 0,
              type: "",
              title: organizationProfileEvent.title,
              startDate: organizationProfileEvent.startDate,
              endDate: DateTime.now(),
              venueId: organizationProfileEvent.venueId,
              images: [],
              //  / isFollowedByAuthUser: false,
              venue: Venue(
                  averageRating: 0,
                  capacity: 0,
                  contactNumber: "0",
                  description: "",
                  latitude: 0,
                  longitude: 0,
                  name: "",
                  profile: "",
                  governorate: "Damascus",
                  id: 1,
                  locationDescription: "")),
          eventId: 0,
          eventTitle: "",
          firstName: bookings[i].firstName.toString(),
          lastName: bookings[i].lastName.toString(),
          id: 0,
          invoiceId: 0,
          status: "paid",
          userId: 0,
          phoneNumber: bookings[i].phoneNumber.toString(),
          userPhoneNumber: bookings[i].phoneNumber.toString()));
    }
    eventDetailsModel = Event(
        capacity: 0,
        description: "",
        organizerId: 0,
        id: eventId,
        ticketPrice: 0,
        type: "",
        title: organizationProfileEvent.title,
        startDate: organizationProfileEvent.startDate,
        endDate: DateTime.now(),
        venueId: organizationProfileEvent.venueId,
        images: [],
        //  / isFollowedByAuthUser: false,
        venue: Venue(
            averageRating: 0,
            capacity: 0,
            contactNumber: "0",
            description: "",
            latitude: 0,
            longitude: 0,
            name: "",
            profile: "",
            governorate: "Damascus",
            id: 1,
            locationDescription: ""));
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
        bookingResponse =
            BookingResponseForOrganizer.fromJson(handlingResponse);
        update();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
    }
  }
}
