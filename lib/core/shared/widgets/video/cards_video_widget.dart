import 'dart:developer';

import '../../../cache_config/cache_config.dart';
import '../../controllers/tween_animation_controller.dart';
import '../../../../features/reels/controller/reels_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CardsVideoWidget extends StatefulWidget {
  CardsVideoWidget(
      {super.key,
      required this.currentVideoUrl,
      required this.videoHgiht,
      required this.videoWidth});
  final String currentVideoUrl;
  final double videoHgiht;
  final double videoWidth;
  @override
  State<CardsVideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<CardsVideoWidget>
    with WidgetsBindingObserver {
  bool videoInitialized = false;
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeController();
  }

  @override
  void didUpdateWidget(covariant CardsVideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentVideoUrl != videoPlayerController.dataSource) {
      // Update the video player if the video URL has changed
      // videoPlayerController.pause();
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
 videoPlayerController.setLooping(false); // Enable looping
          videoPlayerController.setVolume(0); // Mute the video
          videoPlayerController.pause(); // Auto-play the video
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
          _isPlaying = false;
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
       videoPlayerController.setVolume(0);
    videoPlayerController.pause();
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
              alignment: Alignment.center, // Align everything in the center

              children: [
                !videoInitialized
                    ? SizedBox(
                        height: widget.videoHgiht, // Set your height
                        width: widget.videoWidth, // Set your width
                      )
                    : SizedBox(
                        height: widget.videoHgiht, // Set your height
                        width: widget.videoWidth, // Set your width
                        child: FittedBox(
                          fit: BoxFit
                              .cover, // This will prevent the video from being clipped
                          child: SizedBox(
                            height: videoPlayerController.value.size.height,
                            width: videoPlayerController.value.size.width,
                            child: VideoPlayer(videoPlayerController),
                          ),
                        ),
                      ),
                // if (!_isPlaying)
                //   Align(
                //     alignment: Alignment.center, // Center the icon
                //     child: Icon(
                //       Icons.play_arrow,
                //       size: 50.0,
                //       color: Colors.white,
                //     ),
                //   ),
              ],
            ),
          );
  }
}
