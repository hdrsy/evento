import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

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
      phoneNumber: json['phone_number'] ?? 0,
      interest: json['interest'] != null
          ? List<String>.from(jsonDecode(json['interest']))
          : [],
      eventClass: CancelledEventClass.fromJson(json['event_class'] ?? {}),
    );
  }
}
