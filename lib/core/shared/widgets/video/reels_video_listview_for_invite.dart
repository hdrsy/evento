import 'package:better_player_plus/better_player_plus.dart';
import 'package:evento/core/colors/app_colors.dart';
import 'package:evento/core/shared/widgets/video/smooth_indecator.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/services/snackbar_manager.dart';
import 'package:evento/features/reel_pages/show_reel/controller/show_reel_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiVideoPlayerForInvite extends StatefulWidget {
  final List<String> videos;
  final int eventId;
  final int modelId;
  final ShowReelController reelsController = Get.find();

  MultiVideoPlayerForInvite(
      {super.key,
      required this.videos,
      required this.eventId,
      required this.modelId});
  @override
  _MultiVideoPlayerForInviteState createState() =>
      _MultiVideoPlayerForInviteState();
}

class _MultiVideoPlayerForInviteState extends State<MultiVideoPlayerForInvite>
    with SingleTickerProviderStateMixin {
  late List<BetterPlayerDataSource> _dataSourceList;
  late BetterPlayerController _betterPlayerController;
  int _currentIndex = 0;
  bool _isPlayerInitialized = false;
  late AnimationController _animationController;
  late Animation<double> _heartScaleAnimation;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _dataSourceList = createDataSet();
    _initializePlayer();
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Create heart scale animation
    _heartScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    // Listen to animation status
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Heart animation is completed, reset animation after a delay
        Future.delayed(const Duration(milliseconds: 500), () {
          _animationController.reset();
        });
      }
    });
  }

  void _initializePlayer() {
    // Placeholder for aspect ratio determination logic
    // double aspectRatio = 16 / 9; // Default to a common aspect ratio

    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        // aspectRatio: 9 / 16,
        // fit: BoxFit.contain,
        // autoDetectFullscreenAspectRatio: true,
        autoPlay: true,
        looping: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
        ),
      ),
      betterPlayerDataSource: _dataSourceList[_currentIndex],
    );
    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.bufferingStart) {
        setState(() {
          isLoading = true;
        });
      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.bufferingEnd) {
        setState(() {
          isLoading = false;
        });
      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.initialized) {
        setState(() {
          _isPlayerInitialized = true;
          isLoading = false;
          _betterPlayerController.setOverriddenAspectRatio(
              _betterPlayerController.videoPlayerController!.value.aspectRatio);
        });
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
        // Handle the error, e.g., show a Snackbar with an error message
        SnackbarManager.showSnackbar(
            "Error", "An error occurred while playing the video.");
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        _isPlayerInitialized = false;
        if (_currentIndex < _dataSourceList.length - 1) {
          setState(() {
            _currentIndex++;
            _betterPlayerController.dispose();
            _initializePlayer();
          });
        } else {
          widget.reelsController.nextUserPage();
        }
        // widget.reelsController
        //     .playNextVideo(widget.modelIndex, widget.videoIndex);
      }
    });
  }

  List<BetterPlayerDataSource> createDataSet() {
    return List.generate(
        widget.videos.length,
        (index) => BetterPlayerDataSource(
              BetterPlayerDataSourceType.network,
              widget.videos[index],
              liveStream: true,
              videoFormat: BetterPlayerVideoFormat.hls,
              cacheConfiguration: const BetterPlayerCacheConfiguration(
                useCache: true,
                maxCacheSize: 100 * 1024 * 1024, // e.g., 100MB

                maxCacheFileSize: 10 * 1024 * 1024, // e.g., 10MB for each file
              ),
            ));
  }

  void _playNext() {
    if (_currentIndex < _dataSourceList.length - 1) {
      setState(() {
        _isPlayerInitialized = false;

        _currentIndex++;
        _initializePlayer();
      });
    }
  }

  void _showHeartAnimation() {
    _animationController.reset();
    _animationController.forward();
    widget.reelsController
        .followOrUnFollowEvent(widget.eventId, widget.modelId);
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _isPlayerInitialized = false;

        _currentIndex--;
        _initializePlayer();
      });
    }
  }

  @override
  void didUpdateWidget(covariant MultiVideoPlayerForInvite oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.modelId != oldWidget.modelId) {
      _betterPlayerController.pause();
      _betterPlayerController.dispose();
      _initializePlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPressStart: (longPressDownDetails) {
          _betterPlayerController.pause();
        },
        onLongPressEnd: (d) {
          _betterPlayerController.play();
        },
        onDoubleTap: () {
          _showHeartAnimation();
        },
        onTapUp: (TapUpDetails details) {
          final screenWidth = MediaQuery.of(context).size.width;
          final tapPositionX = details.globalPosition.dx;

          if (tapPositionX < screenWidth / 3) {
            _playPrevious();
          } else if (tapPositionX > screenWidth * 2 / 3) {
            _playNext();
          }
        },
        child: Stack(
          // alignment: Alignment.center,
          children: [
            !isLoading
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: List.generate(
                              widget.videos.length, (index) => rr(index))
                          .divide(const SizedBox(
                        width: 3,
                      )),
                    ),
                  )
                : SizedBox.shrink(),
            isLoading
                ? Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: customColors.primary,
                      ),
                    ),
                  )
                : BetterPlayer(controller: _betterPlayerController),
            Center(
              child: AnimatedBuilder(
                animation: _heartScaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _heartScaleAnimation.value,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 50,
                    ),
                  );
                },
              ),
            )
            // : SizedBox(),
          ],
        ));
  }

  Widget rr(int index) {
    return Expanded(
        child: _isPlayerInitialized
            ? CustomSmoothVideoProgress(
                controller: _betterPlayerController,
                builder: (context, position, duration, child) {
                  // Check if the video is initialized before accessing position and duration
                  return LinearProgressIndicator(
                    minHeight: 2,
                    value: index == _currentIndex
                        ? position.inMilliseconds /
                            max(duration.inMilliseconds, 1)
                        : index < _currentIndex
                            ? 1
                            : 0, // Prevent division by zero
                    backgroundColor: AppColors.darkPrimaryBackground,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(customColors.primary),
                  );
                })
            : LinearProgressIndicator(
                minHeight: 2,
                value:
                    index < _currentIndex ? 1 : 0, // Prevent division by zero
                backgroundColor: AppColors.darkPrimaryBackground,
                valueColor: AlwaysStoppedAnimation<Color>(customColors.primary),
              ));
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    _animationController.dispose();

    super.dispose();
  }
}
