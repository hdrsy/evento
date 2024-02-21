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
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      classId: json['class_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      age: json['age'] ?? 0,
      phoneNumber: json['phone_number'] ?? 0,
      interest: interestList.map((e) => e.toString()).toList(),
      reason: json['reason'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
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
    return CancelledEventClass(
      id: json['id'] ?? 0,
      eventId: json['event_id'] ?? 0,
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
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      images: json['images'] != null
          ? List<String>.from(jsonDecode(json['images']).map((x) => x))
          : [],
      startDate: DateTime.parse(json['start_date'] ?? ''),
      endDate: DateTime.parse(json['end_date'] ?? ''),
      venueId: json['venue_id'] ?? 0,
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
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
      id: json['id'] ?? 0,
      governorate: json['governorate'] ?? '',
      locationDescription: json['location_description'] ?? "",
    );
  }
}
