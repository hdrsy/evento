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
    Map<String,dynamic> json= removeDuplicateKeysAr(oldJson);
 
    return OrganizerEvent(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      ticketPrice: json['ticket_price'],
      images: (jsonDecode(json['images']) as List<dynamic>).map((e) => e.toString()).toList(),
      venue: Venue.fromJson(json['venue']),
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
    Map<String,dynamic> json= removeDuplicateKeysAr(oldJson);
 
    return Venue(
      id: json['id'],
      governorate: json['governorate'],
      latitude: json['latitude'],
      longitude: json['longitude'],
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
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}
