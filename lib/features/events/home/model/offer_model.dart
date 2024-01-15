import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class OfferModel{

}

class OfferEvent {
  int id;
  String title;
  DateTime startDate;
  int ticketPrice;
  List<String> images;
  int venueId;
  bool isFollowedByAuthUser;
  Venue venue;
  Offer offer;

  OfferEvent({
    required this.id,
    required this.title,
    required this.startDate,
    required this.ticketPrice,
    required this.images,
    required this.venueId,
    required this.isFollowedByAuthUser,
    required this.venue,
    required this.offer,
  });

  factory OfferEvent.fromJson(Map<String, dynamic> oldJson) {
    Map<String,dynamic> json= removeDuplicateKeysAr(oldJson);
 
    return OfferEvent(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      ticketPrice: json['ticket_price'],
      images: json['images'] != null
          ? List<String>.from(jsonDecode(json['images']))
          : [],
      venueId: json['venue_id'],
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
      venue: Venue.fromJson(json['venue']),
      offer: Offer.fromJson(json['offer']),
    );
  }
}
class Venue {
  int id;
  String governorate;
  double latitude;
  double longitude;

  Venue({
    required this.id,
    required this.governorate,
    required this.latitude,
    required this.longitude,
  });

  factory Venue.fromJson(Map<String, dynamic> oldJson) {
    Map<String,dynamic> json= removeDuplicateKeysAr(oldJson);
 
    return Venue(
      id: json['id'],
      governorate: json['governorate'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}
class Offer {
  int id;
  int eventId;
  int percent;
  
  Offer({
    required this.id,
    required this.eventId,
    required this.percent,
    });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      eventId: json['event_id'],
      percent: json['percent'],
    );
  }
}