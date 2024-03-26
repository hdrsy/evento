import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';

class SearchModel {
  final int id;
  final String title;
  final DateTime startDate;
  final Venue venue;
  final int ticketPrice;
  bool isFollowedByAuthUser;

  final List<String> images;

  SearchModel(
      {required this.id,
      required this.title,
      required this.venue,
      required this.ticketPrice,
      required this.isFollowedByAuthUser,
      required this.startDate,
      required this.images});
  factory SearchModel.fromJson(Map<String, dynamic> oldJson) {
    print("the search :${oldJson}");
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);
    return SearchModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        venue: Venue.fromJson(json['venue'] ?? {}),
        isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
        ticketPrice: json['ticket_price'] ?? 0,
        startDate: json['start_date'] != null
            ? DateTime.parse(json['start_date'])
            : DateTime.now(),
        images: List<String>.from(jsonDecode(json['images']).map((x) => x)));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'images': jsonEncode(images),
    };
  }
}
