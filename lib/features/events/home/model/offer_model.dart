import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class OfferModel {}

class OfferEvent {
  int id;
  String title;
  DateTime startDate;
  int ticketPrice;
  List<String> images;
  int venueId;
  bool isFollowedByAuthUser;
  OfferVenue venue;
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
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);
    return OfferEvent(
      id: json['id'] ?? 0,
      title: json['title'] ?? "UnKnown",
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      ticketPrice: json['ticket_price'] ?? 0,
      images: json['images'] != null
          ? List<String>.from(jsonDecode(json['images']))
          : [],
      venueId: json['venue_id'] ?? 0,
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
      venue: OfferVenue.fromJson(json['venue'] ?? {}),
      offer: Offer.fromJson(json['offer'] ?? {}),
    );
  }
}

class OfferVenue {
  int id;
  String governorate;
  double latitude;
  double longitude;

  OfferVenue({
    required this.id,
    required this.governorate,
    required this.latitude,
    required this.longitude,
  });

  factory OfferVenue.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return OfferVenue(
      id: json['id'] ?? 0,
      governorate: json['governorate'] ?? "UnKnown",
      latitude: json['latitude'].toDouble() ?? 0,
      longitude: json['longitude'].toDouble() ?? 0,
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
      id: json['id'] ?? 0,
      eventId: json['event_id'] ?? 0,
      percent: json['percent'] ?? 0,
    );
  }
}
