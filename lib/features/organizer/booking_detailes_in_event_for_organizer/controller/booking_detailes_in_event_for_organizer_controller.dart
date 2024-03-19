import 'package:evento/features/booking/book_now/model/ticket_model.dart';
import 'package:evento/features/booking/my_booking/model/my_cancel_booking_model.dart';
import 'package:evento/features/booking/my_booking/model/up_coming_booking.dart';
import 'package:get/get.dart';

class BookingDetailesInEventForOrganizerController extends GetxController {
  late List<TicketModel> ticketList;
  late CancelledEvent eventDetailsModel;
  List<TicketModel> generatedTicketModel = [];

  @override
  void onInit() {
    // eventDetailsModel = Get.arguments[0];
    // ticketList = Get.arguments[1];
    // eventDetailsModel = CancelledEvent.fromJson(data['eventDetailsModel']);
    //  var jsonData = jsonDecode(bookingfalse);
    List<EventBooking> bookings = List.from(bookingfalse['bookings'])
        .map<EventBooking>((bookingJson) => EventBooking.fromJson(bookingJson))
        .toList();

    // // Use the bookings list as needed
    bookings.forEach((booking) {});
    createTicketModelsFromEventBookings(bookings);

    super.onInit();
  }

  createTicketModelsFromEventBookings(List<EventBooking> bookings) {
    ticketList.clear();

    for (var i = 0; i < bookings.length; i++) {
      ticketList.add(TicketModel());
      ticketList[i].age.text = bookings[i].age.toString();
      ticketList[i].fisrtName.text = bookings[i].firstName.toString();
      ticketList[i].lastName.text = bookings[i].lastName.toString();
      ticketList[i].phoneNumber.text = bookings[i].phoneNumber.toString();
    }
    // return generatedTicketModel;
  }
}

Map<String, dynamic> data = {
  "eventDetailsModel": {
    "id": 1,
    "title": "Annual Tech Conference",
    "startDate": "2023-10-15T09:00:00Z",
    "endDate": "2023-10-16T18:00:00Z",
    "venueId": 101,
    "isFollowedByAuthUser": false,
    "venue": {
      "id": 101,
      "governorate": "Cairo",
      "locationDescription": "Cairo International Convention Center"
    },
    "images": [
      "https://example.com/images/event1.jpg",
      "https://example.com/images/event2.jpg"
    ]
  }
};
Map<String, dynamic> bookingfalse = {
  "bookings": [
    {
      "id": 1,
      "user_id": 101,
      "class_id": 201,
      "first_name": "John",
      "last_name": "Doe",
      "age": 30,
      "phone_number": "123-456-7890",
      "interest": "Music",
      "event_class": {
        "id": 301,
        "event_id": 401,
        "event": {
          "id": 401,
          "title": "Annual Music Festival",
          "start_date": "2023-07-20T18:00:00Z",
          "end_date": "2023-07-22T23:59:59Z",
          "venue_id": 501,
          "is_followed_by_auth_user": false,
          "venue": {
            "id": 501,
            "governorate": "New York",
            "location_description": "Central Park"
          },
          "images": "https://example.com/images/event1.jpg",
        }
      }
    },
    {
      "id": 2,
      "user_id": 102,
      "class_id": 202,
      "first_name": "Jane",
      "last_name": "Smith",
      "age": 28,
      "phone_number": "987-654-3210",
      "interest": "Art",
      "event_class": {
        "id": 302,
        "event_id": 402,
        "event": {
          "id": 402,
          "title": "Tech Innovators Conference",
          "start_date": "2023-08-15T09:00:00Z",
          "end_date": "2023-08-17T17:00:00Z",
          "venue_id": 502,
          "is_followed_by_auth_user": true,
          "venue": {
            "id": 502,
            "governorate": "San Francisco",
            "location_description": "Moscone Center"
          },
          "images": "https://example.com/images/event3.jpg",
        }
      }
    }
  ]
};
