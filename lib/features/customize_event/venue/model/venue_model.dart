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
   final String profile;
  final String contactNumber;
  final List<VenueAlbum> venueAlbums;

  Venue({
    required this.id,
    required this.name,
    required this.capacity,
    required this.profile,
    required this.governorate,
    required this.locationDescription,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.contactNumber,
    required this.venueAlbums,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    var albumList = json['albums'] as List;
    List<VenueAlbum> albums = albumList.map((album) => VenueAlbum.fromJson(album)).toList();

    return Venue(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
      profile: json['profile'],
      governorate: json['governorate'],
      locationDescription: json['location_description'],
      description: json['description'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      contactNumber: json['contact_number'],
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

  VenueAlbum({
    required this.id,
    required this.venueId,
    required this.name,
    required this.images,
    this.videos,
  });

 factory VenueAlbum.fromJson(Map<String, dynamic> json) {
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
    id: json['id'],
    venueId: json['venue_id'],
    name: json['name'],
    images: parseImages(json['images']),
    videos: json['videos'] ?? [], // Ensure this handles null correctly
  );
}
}
