import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class OrganizerEvent {
  final int id;
  final String title;
  final DateTime startDate;
  final int ticketPrice;
  final List<String> images;
  final Venue venue;

  OrganizerEvent({
    required this.id,
    required this.title,
    required this.startDate,
    required this.ticketPrice,
    required this.images,
    required this.venue,
  });

  factory OrganizerEvent.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return OrganizerEvent(
      id: json['id'] ?? 0,
      title: json['title'] ?? "UnKnown",
      startDate: DateTime.parse(json['start_date']),
      ticketPrice: json['ticket_price'] ?? 0,
      images: json['images'] != null
          ? (jsonDecode(json['images']) as List<dynamic>)
              .map((e) => e.toString())
              .toList()
          : [],
      venue: Venue.fromJson(json['venue'] ?? {}),
    );
  }
}

class Venue {
  final int id;
  final String governorate;
  final double latitude;
  final double longitude;

  Venue({
    required this.id,
    required this.governorate,
    required this.latitude,
    required this.longitude,
  });

  factory Venue.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return Venue(
      id: json['id'] ?? 0,
      governorate: json['governorate'] ?? "UnKnown",
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
    );
  }
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'] ?? '',
      label: json['label'] ?? '',
      active: json['active'] ?? false,
    );
  }
}
