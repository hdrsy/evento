
import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class EventModel {
  final int id;
  final String title;
  final DateTime startDate;
  final int ticketPrice;
  final List<String> images;
  final List<String> videos;
   bool isFollowedByAuthUser;
final  EventHomeVenue? venue;
  EventModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.ticketPrice,
    required this.images,
    required this.videos,
    required this.isFollowedByAuthUser,
    required this.venue
  });

  factory EventModel.fromJson(Map<String, dynamic> oldJson) {
     Map<String,dynamic> json= removeDuplicateKeysAr(oldJson);
   
    return EventModel(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      ticketPrice: json['ticket_price'],
      images: json['images'] != null ? List<String>.from(jsonDecode(json['images']) .map((x) => x)) : [],
      videos: json['videos'] != null ? List<String>.from(jsonDecode(json['videos']) .map((x) => x)) : [],
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
      venue: json.containsKey('venue')?EventHomeVenue.fromJson(json['venue']):null
    );
  }
Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'ticket_price': ticketPrice,
      'images': jsonEncode(images),
      'videos': jsonEncode(videos),
      'is_followed_by_auth_user': isFollowedByAuthUser,
      'venue': venue?.toJson(),
    };}
}

class EventHomeVenue{
  final int id;
  final double long;
  final double lang;
  final String governorate;

  EventHomeVenue({required this.id, required this.long, required this.lang, required this.governorate});
factory EventHomeVenue.fromJson(Map<String, dynamic> oldJson){
   Map<String,dynamic> json= removeDuplicateKeysAr(oldJson);
   
  return EventHomeVenue(id: json['id'], long: json['longitude'], lang: json['latitude'], governorate: json["governorate"]);
}
 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'longitude': long,
      'latitude': lang,
      'governorate': governorate,
    };
  }
}