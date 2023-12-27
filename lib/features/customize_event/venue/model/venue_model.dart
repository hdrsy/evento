import 'dart:convert';

class Venue {
  final int id;
  final String name;
  final int capacity;
  final String governorate;
  final String locationDescription;
  final String description;
  final double latitude;
  final double longitude;
  final String contactNumber;
  final dynamic images; // Can be further defined based on actual data structure
  final dynamic videos; // Can be further defined based on actual data structure
  final List<VenueAlbum> venueAlbums;

  Venue({
    required this.id,
    required this.name,
    required this.capacity,
    required this.governorate,
    required this.locationDescription,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.contactNumber,
    this.images,
    this.videos,
    required this.venueAlbums,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    var albumList = json['albums'] as List;
    List<VenueAlbum> albums = albumList.map((album) => VenueAlbum.fromJson(album)).toList();

    return Venue(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
      governorate: json['governorate'],
      locationDescription: json['location_description'],
      description: json['description'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      contactNumber: json['contact_number'],
      images: json['images'],
      videos: json['videos'],
      venueAlbums: albums,
    );
  }
}

class VenueAlbum {
  final int id;
  final int venueId;
  final String name;
  final List<String> images;
  final dynamic videos;
  final String createdAt;
  final String updatedAt;

  VenueAlbum({
    required this.id,
    required this.venueId,
    required this.name,
    required this.images,
    this.videos,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VenueAlbum.fromJson(Map<String, dynamic> json) {
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

    return VenueAlbum(
      id: json['id'],
      venueId: json['venue_id'],
      name: json['name'],
      images: parseImages(json['images'] as String),
      videos: json['videos'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
