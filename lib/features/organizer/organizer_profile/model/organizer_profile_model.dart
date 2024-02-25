import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class OrganizerProfileModel {
  int id;
  int followingCount;
  int followersCount;
  int organizedEventsCount;
  OrganizerInfo? organizerInfo;
  List<OrganizerProfileEvent> organizedEvents;

  OrganizerProfileModel(
      {required this.id,
      required this.organizerInfo,
      required this.followersCount,
      required this.followingCount,
      required this.organizedEventsCount,
      required this.organizedEvents});

  factory OrganizerProfileModel.fromJson(Map<String, dynamic> json) {
    return OrganizerProfileModel(
      id: json['id'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      organizedEventsCount: json['organized_events_count'] ?? 0,
      organizerInfo: OrganizerInfo.fromJson(json['organizer_info']),
      organizedEvents: json['organized_events'] != null
          ? List<OrganizerProfileEvent>.from(json['organized_events']
              .map((x) => OrganizerProfileEvent.fromJson(x ?? {})))
          : [],
    );
  }
}

class OrganizerInfo {
  int id;
  String name;
  String bio;
  String services;
  String state;
  String profile;
  String cover;
  bool isFollowedByAuthUser;
  List<OrganizerProfileAlbum> albums;
  List<Category> categories;
  OrganizerInfo(
      {required this.id,
      required this.name,
      required this.profile,
      required this.cover,
      required this.categories,
      required this.bio,
      required this.services,
      required this.state,
      required this.isFollowedByAuthUser,
      required this.albums});

  factory OrganizerInfo.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return OrganizerInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      services: json['services'] ?? '',
      state: json['state'] ?? '',
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((x) => Category.fromJson(x ?? {})))
          : [],
      profile: json['profile'] ?? '',
      cover: json['cover'] ?? '',
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
      albums: json['albums'] != null
          ? List<OrganizerProfileAlbum>.from(json['albums']
              .map((x) => OrganizerProfileAlbum.fromJson(x ?? [])))
          : [],
    );
  }
}

class OrganizerProfileAlbum {
  int id;
  String name;
  List<String> images;
  List<String> videos;

  OrganizerProfileAlbum({
    required this.id,
    required this.name,
    required this.images,
    required this.videos,
  });

  factory OrganizerProfileAlbum.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    List<String> parseImages(String imagesJson) {
      if (imagesJson.isEmpty) {
        return [];
      }
      try {
        return List<String>.from(jsonDecode(imagesJson));
      } catch (e) {
        print('Error decoding images JSON: $e');
        return [];
      }
    }

    List<String> parseVideos(String imagesJson) {
      if (imagesJson.isEmpty) {
        return [];
      }
      try {
        return List<String>.from(jsonDecode(imagesJson));
      } catch (e) {
        print('Error decoding images JSON: $e');
        return [];
      }
    }

    return OrganizerProfileAlbum(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      images:
          json['images'] != null ? parseImages(json['images'] as String) : [],
      videos:
          json['videos'] != null ? parseVideos(json['videos'] as String) : [],
    );
  }
}

class Category {
  int id;
  String title;
  String icon;

  Category({
    required this.id,
    required this.title,
    required this.icon,
  });
  factory Category.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return Category(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class OrganizerProfileEvent {
  int id;
  int organizerId;
  String title;
  int venueId;
  int capacity;
  DateTime startDate;
  // DateTime endDate;
  int ticketPrice;
  String description;
  String type;
  dynamic videos;
  List<dynamic> images;
  bool isFollowedByAuthUser;
  OrganizerProfileEvent({
    required this.id,
    required this.organizerId,
    required this.title,
    required this.venueId,
    required this.capacity,
    required this.startDate,
    // required this.endDate,
    required this.ticketPrice,
    required this.description,
    required this.type,
    this.videos,
    required this.images,
    required this.isFollowedByAuthUser,
  });

  factory OrganizerProfileEvent.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);
    print("ddddddddddddd$json");
    return OrganizerProfileEvent(
      id: json['id'] ?? 0,
      organizerId: json['organizer_id'] ?? 0,
      title: json['title'] ?? '',
      venueId: json['venue_id'] ?? 0,
      capacity: json['capacity'] ?? 0,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      // endDate: DateTime.parse(json['end_date']) ?? DateTime.now(),
      ticketPrice: json['ticket_price'] ?? 0,
      description: json['description'] ?? "",
      type: json['type'] ?? "",
      videos: json['videos'] ?? "",
      images: jsonDecode(json['images']),
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
    );
  }
}
