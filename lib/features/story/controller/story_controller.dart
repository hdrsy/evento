// // import 'package:evento/features/reels/controller/reels_controller.dart';
// // import 'package:get/get.dart';
// // import 'package:video_player/video_player.dart';

// // class VideoController extends GetxController{
// //  late VideoPlayerController playerController;
// //   late String videoUrl;
// //   bool isMuted = false; // Track if sound is on or off

// //   final ReelsController reelsController = Get.find();


// //   @override
// //   void onInit() {
// //     videoUrl=Get.arguments[1];
// //     super.onInit();
// //     initializePlayer();
// //   }
// //  void initializePlayer() {
// //     String videoUrl = reelsController.getCurrentVideoUrl();
// //     playerController = VideoPlayerController.networkUrl(Uri.parse(  videoUrl))
// //       ..initialize().then((_) {
// //         playerController.play();
// //         update();
// //       }).catchError((error) {
// //         print("Error initializing video: $error");
// //       });
// //   }
// //    void changeVideo() {
// //     playerController.dispose();
// //     initializePlayer();
// //   }
// //   void previousVideo() {
// //     reelsController.previousVideo();
// //     changeVideo();
// //   }

// //   void nextVideo() {
// //     reelsController.nextVideo();
// //     changeVideo();
// //   }
// //   void playVideo() {
// //     playerController.play();
// //     update();
// //   }

// //   void pauseVideo() {
// //    if (playerController.value.isPlaying) {
// //     playerController.pause();
// //   } else {
// //     playerController.play();
// //   }
// //   update(); 
// //   }
// //     void toggleSound() {
// //     isMuted = !isMuted;
// //     playerController.setVolume(isMuted ? 0.0 : 1.0);
// //     update(); // Update UI if needed
// //   }

// //   @override
// //   void onClose() {
// //     playerController.dispose();
// //     super.onClose();
// //   }
// // }
// import 'package:get/get.dart';

// class ReelsController extends GetxController{
//   late List<RR> videoList;
//   int currentUserIndex = 0;
//   int currentVideoIndex = 0;
//   @override
//   void onInit() {
//     videoList=[
//       RR(id: 0, videosUrl: [
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
//       ], userName: "Ahmad"),
//       RR(id: 1, videosUrl: [
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        
//       ], userName: "Ali"),
//     ];
//     super.onInit();
//   }
//    String getCurrentVideoUrl() {
//     return videoList[currentUserIndex].videosUrl[currentVideoIndex];
//   }

//   String getCurrentUserName() {
//     return videoList[currentUserIndex].userName;
//   }

//   void nextVideo() {
//     if (currentVideoIndex < videoList[currentUserIndex].videosUrl.length - 1) {
//       currentVideoIndex++;
//     } else if (currentUserIndex < videoList.length - 1) {
//       currentUserIndex++;
//       currentVideoIndex = 0;
//     }
//     update();
//   }

//   void previousVideo() {
//     if (currentVideoIndex > 0) {
//       currentVideoIndex--;
//     } else if (currentUserIndex > 0) {
//       currentUserIndex--;
//       currentVideoIndex = videoList[currentUserIndex].videosUrl.length - 1;
//     }
//     update();
//   }
// }

// class RR{
//   final int id;
//   final String userName;
//   final List<String> videosUrl;
//   RR({required this.id,required this.videosUrl,required this.userName});
// }