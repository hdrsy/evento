import 'package:better_player_plus/better_player_plus.dart';
import 'package:evento/core/shared/controllers/tween_animation_controller.dart';
import 'package:evento/features/reels/controller/reels_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelsVideoWidgetWitCaching extends StatefulWidget {
  final String currentVideoUrl;
  final int videoIndex;
  final int modelIndex;
  final int totalVideos;
  final ReelsController reelsController = Get.find();
  final TweenAnimationController tweenAnimationController =
      Get.put(TweenAnimationController());

  ReelsVideoWidgetWitCaching({
    super.key,
    required this.currentVideoUrl,
    required this.videoIndex,
    required this.totalVideos,
    required this.modelIndex,
  });

  @override
  State<ReelsVideoWidgetWitCaching> createState() => _ReelsVideoWidgetState();
}

class _ReelsVideoWidgetState extends State<ReelsVideoWidgetWitCaching> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _dataSource;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.currentVideoUrl,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        maxCacheSize: 100 * 1024 * 1024, // e.g., 100MB
        maxCacheFileSize: 10 * 1024 * 1024, // e.g., 10MB for each file
      ),
    );
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        aspectRatio: 9 / 16,
        fit: BoxFit.cover,
        autoPlay: true,
        looping: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
        ),
      ),
      betterPlayerDataSource: _dataSource,
    );

    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        setState(() {
          isLoading = false;
        });
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        // The progress event gives you the current position as a Duration.
        final Duration currentPosition =
            event.parameters!["progress"] as Duration;
        final Duration? totalDuration =
            _betterPlayerController.videoPlayerController!.value.duration;

        // Ensure totalDuration is not null before performing calculations
        if (totalDuration != null) {
          final double currentProgress =
              currentPosition.inMilliseconds.toDouble() /
                  totalDuration.inMilliseconds.toDouble();
          widget.reelsController.updateProgress(currentProgress);
        }
      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.finished) {
        widget.reelsController.updateProgress(0.0);
        widget.reelsController
            .playNextVideo(widget.modelIndex, widget.videoIndex);
      }

      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        widget.reelsController
            .playNextVideo(widget.modelIndex, widget.videoIndex);
      }
    });
  }

  @override
  void didUpdateWidget(covariant ReelsVideoWidgetWitCaching oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentVideoUrl != oldWidget.currentVideoUrl) {
      _betterPlayerController.pause();
      _betterPlayerController.dispose();
      _initializePlayer();
    }
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: customColors.primary,
            ),
          )
        : AspectRatio(
            aspectRatio: 9 / 16,
            child: BetterPlayer(controller: _betterPlayerController),
          );
  }
}
