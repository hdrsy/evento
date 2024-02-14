import 'dart:math';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:evento/core/shared/controllers/tween_animation_controller.dart';
import 'package:evento/core/shared/widgets/video/smooth_indecator.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
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
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
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
    print(
        "video controller :${_betterPlayerController.videoPlayerController!.value}");

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: customColors.primary,
            ),
          )
        : Column(
            children: [
              Row(
                children:
                    List.generate(widget.totalVideos, (index) => rr(index))
                        .divide(SizedBox(
                  width: 3,
                )),
              ),
              AspectRatio(
                aspectRatio: 9 / 16,
                child: BetterPlayer(controller: _betterPlayerController),
              ),
            ],
          );
  }

  Widget rr(int index) {
    return Expanded(
      child: CustomSmoothVideoProgress(
        controller: _betterPlayerController,
        builder: (context, position, duration, child) {
          return LinearProgressIndicator(
            value: index == widget.videoIndex
                ? position.inMilliseconds / max(duration.inMilliseconds, 1)
                : 0, // Prevent division by zero
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(customColors.primary),
          );
        },
      ),
    );
  }
}
