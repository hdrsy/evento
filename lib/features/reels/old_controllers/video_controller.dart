// import 'package:evento/features/reels/controller/reels_controller.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// class VideoController extends GetxController {
//   late VideoPlayerController playerController;
//   late String videoUrl;
//   bool isMuted = false; // Track if sound is on or off

//   final ReelsController reelsController = Get.find();
//  late int currentVideoIndex; // Track the index of the current video
//   late double currentProgress; // Track the progress of the current video

//   @override
//   void onInit() {
//     super.onInit();
//      currentVideoIndex = reelsController.currentVideoIndex; // Initialize with the current video index from ReelsController
//     currentProgress=0;
//     initializePlayer();
//   }

//   void initializePlayer() {
//     String videoUrl = reelsController.getCurrentVideoUrl();
//     currentVideoIndex = reelsController.currentVideoIndex; 
//     currentProgress=0;
//     playerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
//       ..initialize().then((_) {
//         playerController.play();
//           playerController.addListener(updateProgress); // Add listener to update progress
      
//         update();
//       }).catchError((error) {
//         print("Error initializing video: $error");
//       });
//   }

//   void changeVideo(String newVideoUrl) {
//     videoUrl = newVideoUrl;
//     playerController.removeListener(updateProgress); // Remove listener before disposing
//     playerController.dispose();
      
//     initializePlayer();
//   }
  
//   void updateProgress() {
//     currentProgress = playerController.value.position.inSeconds.toDouble() /
//                       playerController.value.duration.inSeconds.toDouble();
//     update();
//   }

//   void nextVideo() {

//     reelsController.nextVideo(); // Assumes ReelsController handles video index
//   }

//   void previousVideo() {
//     reelsController
//         .previousVideo(); // Assumes ReelsController handles video index
//   }

//   void playVideo() {
//     playerController.play();
//     update();
//   }

//   void pauseVideo() {
//     if (playerController.value.isPlaying) {
//       playerController.pause();
//     } else {
//       playerController.play();
//     }
//     update();
//   }

//   void toggleSound() {
//     isMuted = !isMuted;
//     playerController.setVolume(isMuted ? 0.0 : 1.0);
//     update(); // Update UI if needed
//   }

//   @override
//   void onClose() {
//     playerController.removeListener(updateProgress); // Ensure to remove listener
//     playerController.dispose();
//     super.onClose();
//   }
// }
