import 'package:evento/core/cache_config/cache_config.dart';
import 'package:evento/features/reels/controller/reels_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController with WidgetsBindingObserver {
  VideoPlayerController? playerController;
  final ReelsController reelsController = Get.find();
  bool isMuted = false; // Track if sound is on or off
  late int currentVideoIndex; // Track the index of the current video
  late double currentProgress; // Track the progress of the current video
  bool videoInitialized = false; // Track if the video is initialized
  late String videoUrl;
  bool isLiked=false;
  @override
  void onInit() async {
    super.onInit();
    currentVideoIndex = reelsController.currentVideoIndex;
    currentProgress = 0;
    await initializePlayer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (playerController!.value.isInitialized) {
      if (state == AppLifecycleState.resumed) {
        // App is in the foreground
        playerController!.play();
      } else if (state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        // App is obscured or in the background
        playerController!.pause();
      }
    }
  }

  initializePlayer() async {
    videoUrl = reelsController.getCurrentVideoUrl();
    currentVideoIndex = reelsController.currentVideoIndex;
    currentProgress = 0;
    var fileInfo = await kCacheManager.getFileFromCache(videoUrl);
    if (fileInfo == null) {
      await kCacheManager.downloadFile(videoUrl);
      fileInfo = await kCacheManager.getFileFromCache(videoUrl);
    }

    playerController = VideoPlayerController.file(fileInfo!.file)
      ..initialize().then((_) {
        playerController!.setLooping(true); // Set video to loop
        playerController!.play();
        videoInitialized = true;
        playerController!
            .addListener(updateProgress); // Add listener to update progress
        update();
      }).catchError((error) {
      });
  }

  void changeVideo(String newVideoUrl) async {
    playerController!
        .removeListener(updateProgress); // Remove listener before disposing
    playerController!.dispose();

    initializePlayer();
  }

  void updateProgress() {
    if (!playerController!.value.isInitialized) return;
    currentProgress = playerController!.value.position.inMicroseconds.toDouble() /
        playerController!.value.duration.inMicroseconds.toDouble();
    update();
  }

  void nextVideo() {
    reelsController.nextVideo(); // Assumes ReelsController handles video index
  }

  void previousVideo() {
    reelsController
        .previousVideo(); // Assumes ReelsController handles video index
  }

  void playVideo() {
    playerController!.play();
    update();
  }

  void pauseVideo() {
    if (playerController!.value.isPlaying) {
      playerController!.pause();
    } else {
      playerController!.play();
    }
    update();
  }

  void toggleSound() {
    isMuted = !isMuted;
    playerController!.setVolume(isMuted ? 0.0 : 1.0);
    update(); // Update UI if needed
  }

  @override
  void onClose() {
    playerController!
        .removeListener(updateProgress); // Ensure to remove listener
    WidgetsBinding.instance.removeObserver(this);
    playerController!.dispose();
    super.onClose();
  }
}
