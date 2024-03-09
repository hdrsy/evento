import 'dart:convert';

import 'package:evento/core/server/helper_api.dart';

class Venue {
  final int id;
  final String name;
  final int capacity;
  final String governorate;
  final String locationDescription;
  final String description;
  final double latitude;
  final double longitude;
  final String profile;
  final String contactNumber;
  final List<VenueAlbum> venueAlbums;
final double averageRating;
  Venue({
    required this.id,
    required this.name,
    required this.capacity,
    required this.profile,
    required this.governorate,
    required this.averageRating,
    
    required this.locationDescription,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.contactNumber,
    required this.venueAlbums,
  });

  factory Venue.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    var albumList = json['albums'] == null ? json['albums'] as List : [];
    List<VenueAlbum> albums =
        albumList.map((album) => VenueAlbum.fromJson(album ?? {})).toList();

    return Venue(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      capacity: json['capacity'] ?? 0,
      profile: json['profile'] ?? '',
      governorate: json['governorate'] ?? '',
      averageRating: json['average_rating'] == null
          ? 0
          : double.parse(json['average_rating']),
      locationDescription: json['location_description'] ?? '',
      description: json['description'] ?? '',
      latitude: json['latitude'].toDouble() ?? 0.0,
      longitude: json['longitude'].toDouble() ?? 0.0,
      contactNumber: json['contact_number'] ?? '',
      venueAlbums: albums,
    );
  }
}

class VenueAlbum {
  final int id;
  final int venueId;
  final String name;
  final List<String> images;
  final List<String> videos;

  VenueAlbum({
    required this.id,
    required this.venueId,
    required this.name,
    required this.images,
    required this.videos,
  });

  factory VenueAlbum.fromJson(Map<String, dynamic> oldJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(oldJson);

    List<String> parseImages(String? imagesJson) {
      if (imagesJson == null || imagesJson.isEmpty) {
        return [];
      }
      try {
        // Decode the string to a List<dynamic>, then cast each element to String
        var decodedList = jsonDecode(imagesJson) as List;
        return decodedList.map((item) => item.toString()).toList();
      } catch (e) {
        print('Error decoding images JSON: $e');
        return [];
      }
    }

    return VenueAlbum(
      id: json['id'] ?? 0,
      venueId: json['venue_id'] ?? 0,
      name: json['name'] ?? '',
      images: parseImages(json['images']),
      videos: parseImages(json['videos']),
    );
  }
}
