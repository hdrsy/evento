
import 'dart:convert';

class EventModel {
  final int id;
  final String title;
  final DateTime startDate;
  final int ticketPrice;
  final List<String> images;
  final List<String> videos;
   bool isFollowedByAuthUser;

  EventModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.ticketPrice,
    required this.images,
    required this.videos,
    required this.isFollowedByAuthUser,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    print(json['videos'] );
    return EventModel(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      ticketPrice: json['ticket_price'],
      images: json['images'] != null ? List<String>.from(jsonDecode(json['images']) .map((x) => x)) : [],
      videos: json['videos'] != null ? List<String>.from(jsonDecode(json['videos']) .map((x) => x)) : [],
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
    );
  }
}

