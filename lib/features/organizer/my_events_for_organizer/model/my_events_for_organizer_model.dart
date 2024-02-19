import 'dart:convert';

import 'package:evento/features/events/home/model/category_model.dart';

class OrganizationEvent {
  String title;
  String titleAr;
  int venueId;
  DateTime startDate;
  DateTime endDate;
  List<String> images;
  bool isFollowedByAuthUser;
  Venue venue;
  int capacity;
  int id;
  int bookingCount;
  List<CategoryModel> categoriesEvents;

  OrganizationEvent({
    required this.title,
    required this.titleAr,
    required this.capacity,
    required this.bookingCount,
    required this.venueId,
    required this.startDate,
    required this.endDate,
    required this.id,
    required this.images,
    required this.isFollowedByAuthUser,
    required this.venue,
    required this.categoriesEvents,
  });

  factory OrganizationEvent.fromJson(Map<String, dynamic> json) {
    print("event category:${json['categories_events']}");
    List<String> imageList = [];

    if (json['images'] != null) {
      var imagesJson = jsonDecode(json['images']);
      if (imagesJson is List) {
        imageList = List<String>.from(imagesJson);
      }
    }
    return OrganizationEvent(
      title: json['title'],
      titleAr: json['title_ar'],
      capacity: json['capacity'] ?? 0,
      bookingCount: json['bookings_count'] ?? 0,
      venueId: json['venue_id'],
      id: json['id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      images: imageList,
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
      venue: Venue.fromJson(json['venue']),
      categoriesEvents: List<CategoryModel>.from(
          json['categories_events'].map((x) => CategoryModel.fromJson(x))),
    );
  }
}

class Venue {
  int id;
  String name;
  String nameAr;
  dynamic averageRating;

  Venue({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.averageRating,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      nameAr: json['name_ar'],
      averageRating: json['average_rating'],
    );
  }
}

class EventLink {
  String? url;
  String label;
  bool active;

  EventLink({
    required this.url,
    required this.label,
    required this.active,
  });

  factory EventLink.fromJson(Map<String, dynamic> json) {
    return EventLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}