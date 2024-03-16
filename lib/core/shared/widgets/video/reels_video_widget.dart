import 'dart:math';

import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';

import '../../controllers/tween_animation_controller.dart';
import '../../../../features/reels/controller/reels_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ReelsVideoWidget extends StatefulWidget {
  ReelsVideoWidget(
      {super.key,
      required this.currentVideoUrl,
      required this.videoIndex,
      required this.totalVideos,
      required this.modelIndex});
  final String currentVideoUrl;
  final int videoIndex;
  final int modelIndex;
  final int totalVideos;
  final ReelsController reelsController = Get.find();
  final TweenAnimationController tweenAnimationController =
      Get.put(TweenAnimationController());
  @override
  State<ReelsVideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<ReelsVideoWidget>
    with WidgetsBindingObserver {
  bool videoInitialized = false;
  late VideoPlayerController videoPlayerController;
  bool _isBuffering = false;
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeController();
  }

  @override
  void didUpdateWidget(covariant ReelsVideoWidget oldWidget) {
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
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.currentVideoUrl))
          ..initialize().then((_) {
            setState(() {
              videoPlayerController.setLooping(false); // Set video to loop
              videoPlayerController.play();
              videoInitialized = true;
            });
          }).catchError((error) {
            // Handle the error here
          });
    videoPlayerController.addListener(() {
      final bool isActuallyBuffering = !videoPlayerController.value.isPlaying &&
          videoPlayerController.value.isBuffering;
      if (isActuallyBuffering != _isBuffering) {
        setState(() {
          _isBuffering = isActuallyBuffering;
        });
      }
      if (videoPlayerController.value.isCompleted) {
        final ReelsController reelsController = Get.find();
        // reelsController.nextUser();
        reelsController.playNextVideo(widget.modelIndex, widget.videoIndex);
      }
      if (videoPlayerController.value.isPlaying && !_isPlaying) {
        // Video has started playing
        setState(() {
          _isPlaying = true;
        });
      } else if (!videoPlayerController.value.isPlaying && _isPlaying) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
    // }
  }

  @override
  void dispose() {
    // log('disposing a controller');
    if (mounted) {
      videoPlayerController.dispose();
    } // Dispose of the controller when done
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // bool _isPlaying = false;

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
        ? Center(
            child: CircularProgressIndicator(
              color: customColors.primary,
            ),
          )
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ],
                ),
                Positioned(
                  top: 10,
                  right: 5,
                  child: Container(
                    width: 35,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0x5BFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${widget.videoIndex + 1}/${widget.totalVideos}",
                      textAlign: TextAlign.center,
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.secondaryBackground,
                        fontSize: 12,
                        useGoogleFonts: false,
                      ),
                    ),
                  ),
                ),

                !videoInitialized
                    ? const SizedBox()
                    : Positioned(
                        top: 0,
                        left: 5,
                        right: 5,
                        child: SmoothVideoProgress(
                          controller: videoPlayerController,
                          builder: (context, position, duration, child) {
                            return LinearProgressIndicator(
                              value: position.inMilliseconds /
                                  max(duration.inMilliseconds,
                                      1), // Prevent division by zero
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  customColors.primary),
                            );
                          },
                        ),
                      ),
                //        if (_isBuffering)
                // const CircularProgressIndicator(),
                if (!_isPlaying)
                  const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),

                GetBuilder<TweenAnimationController>(builder: (context) {
                  return widget.tweenAnimationController.aSize.value! > 30
                      ? Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Icon(Icons.favorite,
                              size: widget.tweenAnimationController.aSize.value,
                              color: Colors.red),
                        )
                      : const SizedBox();
                }),
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
