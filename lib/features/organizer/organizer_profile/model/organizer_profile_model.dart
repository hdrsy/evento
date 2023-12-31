import 'dart:convert';

class OrganizerProfileModel {
  int id;
  OrganizerInfo organizerInfo;
  List<OrganizerProfileEvent> organizedEvents;

  OrganizerProfileModel(
      {required this.id,
      required this.organizerInfo,
      required this.organizedEvents});

  factory OrganizerProfileModel.fromJson(Map<String, dynamic> json) =>
      OrganizerProfileModel(
        id: json['id'],
        organizerInfo: OrganizerInfo.fromJson(json['organizer_info']),
        organizedEvents: List<OrganizerProfileEvent>.from(
            json['organized_events'].map((x) => OrganizerProfileEvent.fromJson(x))),
      );
}

class OrganizerInfo {
  int id;
  int categoryId;
  String name;
  String bio;
  String services;
  String state;
  bool isFollowedByAuthUser;
  List<OrganizerProfileAlbum> albums;

  OrganizerInfo(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.bio,
      required this.services,
      required this.state,
      required this.isFollowedByAuthUser,
      required this.albums});

  factory OrganizerInfo.fromJson(Map<String, dynamic> json) => OrganizerInfo(
        id: json['id'],
        categoryId: json['category_id'],
        name: json['name'],
        bio: json['bio'],
        services: json['services'],
        state: json['state'],

        isFollowedByAuthUser: json['is_followed_by_auth_user'],
        albums: List<OrganizerProfileAlbum>.from(json['albums'].map((x) => OrganizerProfileAlbum.fromJson(x))),
      );
}

class OrganizerProfileAlbum {
  int id;
  String name;
  List<String> images;
  List<String> videos;
  

  OrganizerProfileAlbum(
      {required this.id,
      required this.name,
      required this.images,
      required this.videos,
     });

  factory OrganizerProfileAlbum.fromJson(Map<String, dynamic> json) { 
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
        id: json['id'],
        name: json['name'],
        images:json['images']!=null? parseImages(json['images']as String):[],
        videos:json['videos']!=null? parseVideos(json['videos']as String):[],
        );}
}

class OrganizerProfileEvent {
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
  bool organizerIsFollowedByAuthUser;

  OrganizerProfileEvent(
      {required this.id,
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
      required this.organizerIsFollowedByAuthUser});

  factory OrganizerProfileEvent.fromJson(Map<String, dynamic> json) => OrganizerProfileEvent(
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
        organizerIsFollowedByAuthUser:
            json['organizer_is_followed_by_auth_user'],
      );
}
