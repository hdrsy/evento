import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

import '../../../events/event_detailes/model/event_detailes_model.dart';

class EventWrapper {
  int id;
  int eventId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  FavoriteEventModel event;

  EventWrapper({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.event,
  });

  factory EventWrapper.fromJson(Map<String, dynamic> json) {
    print(json['event']);
    return EventWrapper(
      id: json['id'] ?? 0,
      eventId: json['event_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
      event: FavoriteEventModel.fromJson(json['event'] ?? {}),
    );
  }
}

class FavoriteEventModel {
  int id;
  int? organizerId;
  String title;
  int venueId;
  int capacity;
  DateTime startDate;
  DateTime endDate;
  int ticketPrice;
  String description;
  String type;
  List<String> images;
  bool isFollowedByAuthUser;
  Venue venue;

  FavoriteEventModel(
      {required this.id,
      this.organizerId,
      required this.title,
      required this.venueId,
      required this.capacity,
      required this.startDate,
      required this.endDate,
      required this.ticketPrice,
      required this.description,
      required this.type,
      required this.images,
      required this.isFollowedByAuthUser,
      required this.venue});

  factory FavoriteEventModel.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return FavoriteEventModel(
      id: json['id'] ?? 0,
      organizerId: json['organizer_id'] ?? 0,
      title: json['title'] ?? '',
      venueId: json['venue_id'] ?? 0,
      capacity: json['capacity'] ?? 0,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      ticketPrice: json['ticket_price'] ?? 0,
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      venue: Venue.fromJson(json["venue"] ?? {}),
      images: List<String>.from(jsonDecode(json['images'] ?? '[]')),
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
    );
  }
}
