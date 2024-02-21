import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class ServiceProvider {
  final int id;
  final int userId;
  final int categoryId;
  final String locationWorkGovernorate;
  final String address;
  final String profile;
  final String cover;
  final String description;
  final double? latitude;
  final double? longitude;
  final double? rating;

  final User user;
  final List<Album> albums;

  ServiceProvider({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.locationWorkGovernorate,
    required this.address,
    required this.profile,
    required this.cover,
    required this.description,
    required this.user,
    required this.rating,
    required this.albums,
    required this.latitude,
    required this.longitude,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    var albumList = json['albums'] as List;
    List<Album> albums =
        albumList.map((album) => Album.fromJson(album)).toList();
    print(json);
    return ServiceProvider(
      id: json['id'] ?? 0,
      latitude: json['latitude'] != null ? json['latitude'].toDouble() : null,
      longitude:
          json['longitude'] != null ? json['longitude'].toDouble() : null,
      userId: json['user_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      locationWorkGovernorate: json['location_work_governorate'] ?? '',
      address: json['address'] ?? '',
      profile: json['profile'] ?? '',
      cover: json['cover'] ?? "",
      rating: json['average_rating'] != null
          ? double.parse(json['average_rating'])
          : 0,
      description: json['description'] ?? "",
      user: User.fromJson(json['user']),
      albums: albums,
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}

class Album {
  final int id;
  final int serviceProviderId;
  final String name;
  final List<String> images;
  final List<String>
      videos; // Can be further defined based on actual data structure
  final String createdAt;
  final String updatedAt;

  Album({
    required this.id,
    required this.serviceProviderId,
    required this.name,
    required this.images,
    required this.videos,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Album.fromJson(Map<String, dynamic> oldJson) {
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

    return Album(
      id: json['id'] ?? 0,
      serviceProviderId: json['service_provider_id'] ?? 0,
      name: json['name'],
      images:
          json['images'] != null ? parseImages(json['images'] as String) : [],
      videos:
          json['videos'] != null ? parseVideos(json['videos'] as String) : [],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
