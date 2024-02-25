import 'dart:convert';

import '../../events/event_detailes/model/event_detailes_model.dart';
import '../../events/home/model/event_model.dart';

class ReelModel {
  final int id;
  final int? eventId;
  final int? userId;
  final int? venueId;
  final List<String> videos;
  final List<String?>? images;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  int likesCount;
  final int commentsCount;
  bool likedByUser;
  final EventModel? event;
  final Venue? venue;
  final User? user;

  ReelModel({
    required this.id,
    this.eventId,
    this.userId,
    required this.venueId,
    required this.videos,
    required this.images,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.likedByUser,
    this.event,
    required this.venue,
    this.user,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    // Map<String,dynamic> json= removeDuplicateKeysAr(oldJson);
    print("evnt in reel:${json['event']}");
    return ReelModel(
      id: json['id'] ?? 0,
      eventId: json['event_id'],
      userId: json['user_id'],
      venueId: json['venue_id'],
      videos: json['videos'] != null
          ? List<String>.from(jsonDecode(json['videos']).map((x) => x))
          : [],
      images: json['images'] != null
          ? List<String>.from(jsonDecode(json['images']).map((x) => x))
          : [],
      description: json['description'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      likedByUser: json['liked_by_user'] ?? false,
      event: json['event'] != null
          ? EventModel.fromJson(json['event'] ?? {})
          : null,
      venue: json['venue'] != null ? Venue.fromJson(json['venue'] ?? {}) : null,
      user: json['user'] != null ? User.fromJson(json['user'] ?? {}) : null,
    );
  }
}
