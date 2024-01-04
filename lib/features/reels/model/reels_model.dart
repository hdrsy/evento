import 'dart:convert';

import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/features/events/home/model/event_model.dart';

class ReelModel {
    final int id;
    final int? eventId;
    final int? userId;
    final int? venueId;
    final List<String> videos;
    final List<String?>? images;
    final String description;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int likesCount;
    final int commentsCount;
    final bool likedByUser;
    final EventModel? event;
    final Venue? venue;
    final User? user;

    ReelModel({
        required this.id,
        this.eventId,
        this.userId,
        required this.venueId,
        required this.videos,
        required this.images,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.likesCount,
        required this.commentsCount,
        required this.likedByUser,
        this.event,
        required this.venue,
        this.user,
    });

    factory ReelModel.fromJson(Map<String, dynamic> json)  {
      json['images'];
      return
      ReelModel(
        id: json['id'],
        eventId: json['event_id'],
        userId: json['user_id'],
        venueId: json['venue_id'],
        videos: List<String>.from(jsonDecode(json['videos'])),
        images: List<String>.from(jsonDecode(json['images']))??[],
        description: json['description'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        likesCount: json['likes_count'],
        commentsCount: json['comments_count'],
        likedByUser: json['liked_by_user'],
        event: json['event'] != null ? EventModel.fromJson(json['event']) : null,
        venue:json['venue']!=null? Venue.fromJson(json['venue']):null,
        user: json['user'] != null ? User.fromJson(json['user']) : null,
    );}
}
// class User {
//     // Define fields for the User class
//     // Implement a constructor and fromJson method similar to ReelModel
// }



// class RR {
//   final int id;
//   final String userName;
//   final List<VideoDetails> videos; // List of videos with details

//   RR({
//     required this.id,
//     required this.videos, // Updated to list of VideoDetails
//     required this.userName,
//   });
//    Map<String, dynamic> toJson() => {
//     "id": id,
//     "userName": userName,
//     "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
//   };
//   factory RR.fromJson(Map<String, dynamic> json) => RR(
//     id: json["id"],
//     userName: json["userName"],
//     videos: List<VideoDetails>.from(json["videos"].map((x) => VideoDetails.fromJson(x))),
//   );
// }

// class VideoDetails {
//   final String url;
//   final String description;
//     bool isLiked;
//   final String date; // Assuming date is a String for simplicity

//   VideoDetails({
//     required this.url,
//     required this.description,
//     this.isLiked=false,
//     required this.date,
//   });
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "description": description,
//     "date": date,
//   };
//   factory VideoDetails.fromJson(Map<String, dynamic> json) => VideoDetails(
//     url: json["url"],
//     description: json["description"],
//     date: json["date"],
//   );
// }

// List<RR> getFakeData() {
//   return [
//     RR(
//       id: 0,
//       userName: "User 1",
//       videos: [
//         VideoDetails(
//           url:
//         'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
//              description: 'A story of a giant rabbit.',
//           date: '2023-01-01',
//         ),
//         VideoDetails(
//           url:
//               'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
//           description: 'The first Blender Open Movie from 2006.',
//           date: '2023-01-02',
//         ),
//         VideoDetails(
//           url:
//               'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
//           description: 'The first Blender Open Movie from 2006.',
//           date: '2023-01-02',
//         ),
//       ],
//     ),
//     RR(
//       id: 1,
//       userName: "User 2",
//       videos: [
//         VideoDetails(
//           url:
//               'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
//           description: 'A Chromecast promotional video.',
//           date: '2023-01-03',
//         ),
//         VideoDetails(
//           url:
//               'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
//           description: 'A video showcasing Chromecast.',
//           date: '2023-01-04',
//         ),
//       ],
//     ),
//     RR(
//       id: 2,
//       userName: "User 3",
//       videos: [
//         VideoDetails(
//           url:
//               'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
//           description: 'Promoting Chromecast features.',
//           date: '2023-02-01',
//         ),
//         VideoDetails(
//           url:
//               'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
//           description: 'Another Chromecast advertisement.',
//           date: '2023-02-02',
//         ),
//       ],
//     ),
//     RR(
//       id: 3,
//       userName: "User 4",
//       videos: [
//         VideoDetails(
//           url:
//               'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
//           description: 'Chromecast advertisement.',
//           date: '2023-03-01',
//         ),
//         VideoDetails(
//           url:
//               'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
//           description: 'A short film by Blender Foundation.',
//           date: '2023-03-02',
//         ),
//       ],
//     ),
//     // Add more RR objects as needed
//   ];
// }


