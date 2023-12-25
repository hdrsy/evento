import 'dart:developer';

import 'package:evento/core/cache_config/cache_config.dart';
import 'package:evento/core/shared/controllers/tween_animation_controller.dart';
import 'package:evento/features/reels/controller/reels_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  VideoWidget({super.key, required this.currentVideoUrl});
  final String currentVideoUrl;
  final ReelsController reelsController = Get.find();
  final TweenAnimationController tweenAnimationController =
      Get.put(TweenAnimationController());
  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> with WidgetsBindingObserver {
  bool videoInitialized = false;
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeController();
  }

  @override
  void didUpdateWidget(covariant VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentVideoUrl != videoPlayerController.dataSource) {
      // Update the video player if the video URL has changed
      videoPlayerController.pause();
      videoPlayerController.dispose();
      initializeController();
      setState(() {});
    }
  }

  initializeController() async {
    // var fileInfo = await kCacheManager.getFileFromCache(widget.currentVideoUrl);
    // if (fileInfo == null) {
    //   await kCacheManager.downloadFile(widget.currentVideoUrl);
    //   fileInfo = await kCacheManager.getFileFromCache(widget.currentVideoUrl);
    // }
    // if (mounted) {
      // videoPlayerController = VideoPlayerController.file(fileInfo!.file)
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse( widget.currentVideoUrl))
        ..initialize().then((_) {
          setState(() {
            videoPlayerController.setLooping(false); // Set video to loop
            videoPlayerController.play();
            videoInitialized = true;
          });
        }).catchError((error) {
    // Handle the error here
    print("Error initializing video player: $error");
  });
      videoPlayerController.addListener(() {
        if (videoPlayerController.value.isPlaying && !_isPlaying) {
          // Video has started playing
          setState(() {
            _isPlaying = true;
          });
        }
      });
    // }
  }

  @override
  void dispose() {
    log('disposing a controller');
    if (mounted) {
      videoPlayerController.dispose();
    } // Dispose of the controller when done
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool _isPlaying = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      videoPlayerController.play();
    } else if (state == AppLifecycleState.inactive) {
      // App is partially obscured
      videoPlayerController.pause();
    } else if (state == AppLifecycleState.paused) {
      // App is in the background
      videoPlayerController.pause();
    } else if (state == AppLifecycleState.detached) {
      // App is terminated
      videoPlayerController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return !videoInitialized
        ? SizedBox()
        : GestureDetector(
            onDoubleTap: onDoubleTap,
            onTap: () {
              if (videoInitialized) {
                setState(() {
                  if (videoPlayerController.value.isPlaying) {
                    videoPlayerController.pause();
                    _isPlaying = false;
                  } else {
                    videoPlayerController.play();
                    _isPlaying = true;
                  }
                });
              }
            },
            child: Stack(
              children: [
                 !videoInitialized
                    ? const SizedBox()
                    : VideoProgressIndicator(
                        videoPlayerController,
                        allowScrubbing: true,
                        colors:  VideoProgressColors(
                          playedColor: customColors.primary,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.white,
                        ),
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ],
                ),
                if (!_isPlaying)
                  const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),

                GetBuilder<TweenAnimationController>(
                  builder: (context) {
                    return widget.tweenAnimationController.aSize.value! > 30
                        ? Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Icon(Icons.favorite,
                                size: widget.tweenAnimationController.aSize.value,
                                color: Colors.red),
                          )
                        : const SizedBox();
                  }
                ),
              ],
            ),
          );
  }

  void onDoubleTap() {
    if (widget.tweenAnimationController.aColor.value == Colors.red) {
      widget.tweenAnimationController.aController.reverse();
    } else {
      widget.tweenAnimationController.aController.forward();
    }

    // widget.reelsController.itemList[widget.reelsController.currentUserIndex]
    //     .videos[0].isLiked = true;
  }
}
