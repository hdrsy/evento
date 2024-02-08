import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class CancelledBooking {
  final int id;
  final int userId;
  final int classId;
  final String firstName;
  final String lastName;
  final int age;
  final String phoneNumber;
  final List<String> interest;
  final String reason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CancelledEventClass eventClass;

  CancelledBooking({
    required this.id,
    required this.userId,
    required this.classId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phoneNumber,
    required this.interest,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
    required this.eventClass,
  });

  factory CancelledBooking.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    var interestList = jsonDecode(json['interest']) as List<dynamic>;
    return CancelledBooking(
      id: json['id'],
      userId: json['user_id'],
      classId: json['class_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      phoneNumber: json['phone_number'],
      interest: interestList.map((e) => e.toString()).toList(),
      reason: json['reason'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      eventClass: CancelledEventClass.fromJson(json['event_class']),
    );
  }
}

class CancelledEventClass {
  final int id;
  final int eventId;
  final CancelledEvent event;

  CancelledEventClass({
    required this.id,
    required this.eventId,
    required this.event,
  });

  factory CancelledEventClass.fromJson(Map<String, dynamic> json) {
    print("ccc $json");
    return CancelledEventClass(
      id: json['id'],
      eventId: json['event_id'],
      event: CancelledEvent.fromJson(json['event']),
    );
  }
}

class CancelledEvent {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final int venueId;
  final bool isFollowedByAuthUser;
  final CancelledVenue venue;
  final List<String> images;
  CancelledEvent({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.venueId,
    required this.images,
    required this.isFollowedByAuthUser,
    required this.venue,
  });

  factory CancelledEvent.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return CancelledEvent(
      id: json['id'],
      title: json['title'],
      images: json['images'] != null
          ? List<String>.from(jsonDecode(json['images']).map((x) => x))
          : [],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      venueId: json['venue_id'],
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
      venue: CancelledVenue.fromJson(json['venue']),
    );
  }
}

class CancelledVenue {
  final int id;
  final String governorate;
  final String locationDescription;

  CancelledVenue({
    required this.id,
    required this.governorate,
    required this.locationDescription,
  });

  factory CancelledVenue.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return CancelledVenue(
      id: json['id'],
      governorate: json['governorate'],
      locationDescription: json['location_description'],
    );
  }
}
