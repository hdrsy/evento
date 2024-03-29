import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class OrganizationProfileModel {
  int id;
  int followingCount;
  int followersCount;
  String name;
  String bio;
  String services;
  String state;
  String? profile;
  String? cover;
  String? otherCategory;
  bool isFollowedByAuthUser;
  List<OrganizationProfileAlbum> albums;
  List<Category> categories;

  int organizedEventsCount;
  List<OrganizationProfileEvent> organizedEvents;

  OrganizationProfileModel(
      {required this.id,
      required this.followersCount,
      required this.followingCount,
      required this.organizedEventsCount,
      required this.organizedEvents,
      required this.name,
      required this.profile,
      required this.cover,
      required this.categories,
      required this.bio,
      required this.otherCategory,
      required this.services,
      required this.state,
      required this.isFollowedByAuthUser,
      required this.albums});

  factory OrganizationProfileModel.fromJson(Map<String, dynamic> json) {
    return OrganizationProfileModel(
      id: json['id'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      organizedEventsCount: json['organized_events_count'] ?? 0,
      organizedEvents: json['organized_events'] != null
          ? List<OrganizationProfileEvent>.from(json['organized_events']
              .map((x) => OrganizationProfileEvent.fromJson(x)))
          : [],
      name: json['name'] ?? "Unknown",
      bio: json['bio'] ?? "",
      services: json['services'] ?? "",
      otherCategory: json['other_category'] ?? "",
      state: json['covering_area'] ?? '',
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((x) => Category.fromJson(x)))
          : [],
      profile: json['profile'] ?? '',
      cover: json['cover'] ?? '',
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
      albums: json['albums'] != null
          ? List<OrganizationProfileAlbum>.from(
              json['albums'].map((x) => OrganizationProfileAlbum.fromJson(x)))
          : [],
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
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class OrganizationProfileEvent {
  int id;
  int organizerId;
  String title;
  int venueId;
  DateTime startDate;
  List<dynamic> images;
  bool isFollowedByAuthUser;
  OrganizationProfileEvent({
    required this.id,
    required this.organizerId,
    required this.title,
    required this.venueId,
    required this.startDate,
    required this.images,
    required this.isFollowedByAuthUser,
  });

  factory OrganizationProfileEvent.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);
    List<String> imageList = [];

    if (json['images'] != null) {
      var imagesJson = jsonDecode(json['images']);
      if (imagesJson is List) {
        imageList = List<String>.from(imagesJson);
      }
    }
    return OrganizationProfileEvent(
      id: json['id'] ?? 0,
      organizerId: json['organizer_id'] ?? 0,
      title: json['title'] ?? '',
      venueId: json['venue_id'] ?? 0,
      startDate: DateTime.parse(json['start_date'] ?? ''),
      images: imageList,
      isFollowedByAuthUser: json['is_followed_by_auth_user'] ?? false,
    );
  }
}
