import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';

import 'my_cancel_booking_model.dart';

class UpComingBooking {
  int userId;
  int eventId;
  List<EventBooking> bookings;

  UpComingBooking({
    required this.userId,
    required this.eventId,
    required this.bookings,
  });

  factory UpComingBooking.fromJson(Map<String, dynamic> json) =>
      UpComingBooking(
        userId: json['user_id'] ?? 0,
        eventId: json['event_id'] ?? 0,
        bookings: json['bookings'] != null
            ? List<EventBooking>.from(
                json['bookings'].map((x) => EventBooking.fromJson(x)))
            : [],
      );
}

class EventBooking {
  int id;
  int userId;
  int classId;
  String firstName;
  String lastName;
  int age;
  String phoneNumber;
  List<String> interest;
  CancelledEventClass eventClass;

  EventBooking({
    required this.id,
    required this.userId,
    required this.classId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phoneNumber,
    required this.interest,
    required this.eventClass,
  });

  factory EventBooking.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return EventBooking(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      classId: json['class_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      age: json['age'] ?? 0,
      phoneNumber: json['user_phone_number'] ?? 0,
      interest: json['interest'] != null
          ? List<String>.from(jsonDecode(json['interest']))
          : [],
      eventClass: CancelledEventClass.fromJson(json['event'] ?? {}),
    );
  }
}

class BookingResponse {
  List<Booking> upcomingBookings;

  BookingResponse({required this.upcomingBookings});

  factory BookingResponse.fromJson(List<dynamic> json) {
    // List<Booking> bookingsList = [];
    // for (var bookingList in json) {
    List<Booking> bookings = List<Booking>.from(
        json.map((eventBooking) => Booking.fromJson(eventBooking)));
    // bookingsList.add(bookings);
    // }

    return BookingResponse(upcomingBookings: bookings);
  }
}

class Booking {
  int id;
  int userId;
  int eventId;
  String userPhoneNumber;
  String eventTitle;
  String classType;
  String firstName;
  String lastName;
  int age;
  String phoneNumber;
  List<Amenity> amenities;
  String status;
  Event event;

  Booking({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.userPhoneNumber,
    required this.eventTitle,
    required this.classType,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phoneNumber,
    required this.amenities,
    required this.status,
    required this.event,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      eventId: json['event_id'],
      userPhoneNumber: json['user_phone_number'],
      eventTitle: json['event_title'],
      classType: json['class_type'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      phoneNumber: json['phone_number'],
      amenities: (json['amenities'] as List<dynamic>)
          .map((amenity) => Amenity.fromJson(amenity))
          .toList(),
      status: json['status'],
      event: Event.fromJson(json['event']),
    );
  }
}

class Event {
  int id;
  int organizerId;
  String title;
  String titleAr;
  int venueId;
  int capacity;
  DateTime startDate;
  DateTime endDate;
  int ticketPrice;
  String description;
  String descriptionAr;
  String type;
  List<String> images;
  Venue venue;

  Event({
    required this.id,
    required this.organizerId,
    required this.title,
    required this.titleAr,
    required this.venueId,
    required this.capacity,
    required this.startDate,
    required this.endDate,
    required this.ticketPrice,
    required this.description,
    required this.descriptionAr,
    required this.type,
    required this.images,
    required this.venue,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      organizerId: json['organizer_id'],
      title: json['title'],
      titleAr: json['title_ar'],
      venueId: json['venue_id'],
      capacity: json['capacity'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      ticketPrice: json['ticket_price'],
      description: json['description'],
      descriptionAr: json['description_ar'],
      type: json['type'],
      images: json['images'] != null
          ? jsonDecode(json['images']).cast<String>()
          : [],
      venue: Venue.fromJson(json['venue']),
    );
  }
}

class Venue {
  int id;
  String name;
  String nameAr;
  int capacity;
  String governorate;
  String locationDescription;
  String locationDescriptionAr;
  String description;
  String descriptionAr;
  double latitude;
  double longitude;
  String profile;
  String contactNumber;
  double? averageRating;

  Venue({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.capacity,
    required this.governorate,
    required this.locationDescription,
    required this.locationDescriptionAr,
    required this.description,
    required this.descriptionAr,
    required this.latitude,
    required this.longitude,
    required this.profile,
    required this.contactNumber,
    required this.averageRating,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      nameAr: json['name_ar'],
      capacity: json['capacity'],
      governorate: json['governorate'],
      locationDescription: json['location_description'],
      locationDescriptionAr: json['location_description_ar'],
      description: json['description'],
      descriptionAr: json['description_ar'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      profile: json['profile'],
      contactNumber: json['contact_number'],
      averageRating: json['average_rating'],
    );
  }
}
