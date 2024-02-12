import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class OrganizationProfileModel {
  int id;
  int followingCount;
  int followersCount;
  int organizedEventsCount;
  OrganizerInfo organizerInfo;
  List<OrganizationProfileEvent> organizedEvents;

  OrganizationProfileModel(
      {required this.id,
      required this.organizerInfo,
      required this.followersCount,
      required this.followingCount,
      required this.organizedEventsCount,
      required this.organizedEvents});

  factory OrganizationProfileModel.fromJson(Map<String, dynamic> json) {
    print(json['followers_count']);
    return OrganizationProfileModel(
      id: json['id'],
      followersCount: json['followers_count'],
      followingCount: json['following_count'],
      organizedEventsCount: json['organized_events_count'],
      organizerInfo: OrganizerInfo.fromJson(json['organizer_info']),
      organizedEvents: List<OrganizationProfileEvent>.from(
          json['organized_events']
              .map((x) => OrganizationProfileEvent.fromJson(x))),
    );
  }
}

class OrganizerInfo {
  int id;
  String name;
  String bio;
  String services;
  String state;
  String? profile;
  String? cover;
  bool isFollowedByAuthUser;
  List<OrganizationProfileAlbum> albums;
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
      id: json['id'],
      name: json['name'],
      bio: json['bio'],
      services: json['services'],
      state: json['state'],
      categories: List<Category>.from(
          json['categories'].map((x) => Category.fromJson(x))),
      profile: json['profile'],
      cover: json['cover'],
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
      albums: List<OrganizationProfileAlbum>.from(
          json['albums'].map((x) => OrganizationProfileAlbum.fromJson(x))),
    );
  }
}

class OrganizationProfileAlbum {
  int id;
  String name;
  List<String> images;
  List<String> videos;

  OrganizationProfileAlbum({
    required this.id,
    required this.name,
    required this.images,
    required this.videos,
  });

  factory OrganizationProfileAlbum.fromJson(Map<String, dynamic> oldJson) {
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

    return OrganizationProfileAlbum(
      id: json['id'],
      name: json['name'],
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
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
    );
  }
}

class OrganizationProfileEvent {
  int id;
  int organizerId;
  String title;
  int venueId;
  int capacity;
  DateTime startDate;
  DateTime endDate;
  int ticketPrice;
  String description;
  String type;
  dynamic videos;
  List<dynamic> images;
  bool isFollowedByAuthUser;
  OrganizationProfileEvent({
    required this.id,
    required this.organizerId,
    required this.title,
    required this.venueId,
    required this.capacity,
    required this.startDate,
    required this.endDate,
    required this.ticketPrice,
    required this.description,
    required this.type,
    this.videos,
    required this.images,
    required this.isFollowedByAuthUser,
  });

  factory OrganizationProfileEvent.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    return OrganizationProfileEvent(
      id: json['id'],
      organizerId: json['organizer_id'],
      title: json['title'],
      venueId: json['venue_id'],
      capacity: json['capacity'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      ticketPrice: json['ticket_price'],
      description: json['description'],
      type: json['type'],
      videos: json['videos'],
      images: jsonDecode(json['images']),
      isFollowedByAuthUser: json['is_followed_by_auth_user'],
    );
  }
}
