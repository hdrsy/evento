import 'dart:convert';

class RelatedEventModel {
  final int id;
  final int? organizerId;
  final String title;
  final int venueId;
  final int capacity;
  final DateTime startDate;
  final DateTime endDate;
  final double ticketPrice;
  final String description;
  final String type;
  final List<String>? videos;
  final List<String> images;
  final bool isFollowedByAuthUser;
  final bool organizerIsFollowedByAuthUser;

  RelatedEventModel({
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
    this.videos,
    required this.images,
    required this.isFollowedByAuthUser,
    required this.organizerIsFollowedByAuthUser,
  });

  factory RelatedEventModel.fromJson(Map<String, dynamic> json) {
    return RelatedEventModel(
      id: json['id'],
      organizerId: json['organizer_id'],
      title: json['title'],
      venueId: json['venue_id'],
      capacity: json['capacity'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      ticketPrice: json['ticket_price'].toDouble(),
      description: json['description'],
      type: json['type'],
      videos: json['videos'] != null ? List<String>.from(json['videos']) : null,
      images: List<String>.from(jsonDecode(json['images']).cast<String>().map((image) => image.toString())),
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
      organizerIsFollowedByAuthUser: json['organizer_is_followed_by_auth_user'],
    );
  }
}
