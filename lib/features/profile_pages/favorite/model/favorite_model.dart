import 'dart:convert';

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
    return EventWrapper(
      id: json['id'],
      eventId: json['event_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      event: FavoriteEventModel.fromJson(json['event']),
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
  bool organizerIsFollowedByAuthUser;

  FavoriteEventModel({
    required this.id,
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
    required this.organizerIsFollowedByAuthUser,
  });

  factory FavoriteEventModel.fromJson(Map<String, dynamic> json) {
    return FavoriteEventModel(
      id: json['id'],
      organizerId: json['organizer_id'],
      title: json['title'],
      venueId: json['venue_id'],
      capacity: json['capacity'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      ticketPrice: json['ticket_price'],
      description: json['description'],
      type: json['type'],
      images: List<String>.from(jsonDecode(json['images'] ?? '[]')),
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
      organizerIsFollowedByAuthUser: json['organizer_is_followed_by_auth_user'],
    );
  }
}
