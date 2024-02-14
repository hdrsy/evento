import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Define the type for the sound control callback function.
typedef SoundControlCallback = bool Function();

class CardsVideoWidget extends StatefulWidget {
  const CardsVideoWidget(
      {super.key,
      required this.currentVideoUrl,
      required this.soundControlCallback, // Require the callback in the constructor

      required this.videoHgiht,
      required this.videoWidth});
  final SoundControlCallback soundControlCallback; // Add the callback here
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

  void _setVideoSound() {
    bool playSound = widget
        .soundControlCallback(); // Call the callback to determine sound state
    print(playSound);
    videoPlayerController
        .setVolume(playSound ? 1.0 : 0.0); // Set volume based on callback
    print(videoPlayerController.value.volume);
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
        ? const SizedBox()
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
              ],
            ),
          );
  }
}
