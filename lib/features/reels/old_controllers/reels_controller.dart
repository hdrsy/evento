// import 'package:evento/features/reels/controller/video_controller.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// class ReelsController extends GetxController {

//  @override
//   void onClose() {
//       Get.find<VideoController>().dispose();  // Dispose the existing instance
 
//     super.onClose();

//   }
//   late List<RR> videoList;
//   late int
//       currentVideoIndex; // Index of the current video in the current user's video list
//   late int currentUserIndex; // Index of the current user

//   @override
//   void onInit() {
//     videoList = getFakeData();
//     currentVideoIndex = 0;
//     currentUserIndex = 0;
//     Get.lazyPut<VideoController>(() => VideoController());
//     super.onInit();
//   }

//   VideoDetails getCurrentVideo() {
//     return videoList[currentUserIndex].videos[currentVideoIndex];
//   }

//   String getCurrentVideoUrl() {
//     return getCurrentVideo().url;
//   }

//   void nextVideo() {
//     if (currentVideoIndex + 1 < videoList[currentUserIndex].videos.length) {
//       currentVideoIndex++;
//       update();
//       VideoController videoController = Get.find();
//       videoController.changeVideo(getCurrentVideoUrl());
//     }
//   }

//   void previousVideo() {
//     if (currentVideoIndex > 0) {
//       currentVideoIndex--;
//       update();
//       VideoController videoController = Get.find();
//       videoController.changeVideo(getCurrentVideoUrl());
//     }
//   }

//   void nextUser() {
//     if (currentUserIndex + 1 < videoList.length) {
//       currentUserIndex++;
//       currentVideoIndex = 0; // Reset to the first video of the next user
//       update();
//       VideoController videoController = Get.find();
//       videoController.changeVideo(getCurrentVideoUrl());
//     }
//   }

//   void previousUser() {
//     if (currentUserIndex > 0) {
//       currentUserIndex--;
//       currentVideoIndex = 0; // Reset to the first video of the previous user
//       update();
//       VideoController videoController = Get.find();
//       videoController.changeVideo(getCurrentVideoUrl());
//     }
//   }
  
// }

// List<RR> getFakeData() {
//   return [
//     RR(
//       id: 0,
//       userName: "User 1",
//       videos: [
//         VideoDetails(
//           url:
//               'https://mixkit.co/free-stock-video/aerial-panorama-of-a-landscape-with-mountains-and-a-lake-42491/',
//           description: 'A story of a giant rabbit.',
//           date: '2023-01-01',
//         ),
//         VideoDetails(
//           url:
//               'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
//           description: 'The first Blender Open Movie from 2006.',
//           date: '2023-01-02',
//         ),
//         VideoDetails(
//           url:
//               'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
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
//   final String date; // Assuming date is a String for simplicity

//   VideoDetails({
//     required this.url,
//     required this.description,
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
