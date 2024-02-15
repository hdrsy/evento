import 'package:better_player_plus/better_player_plus.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class BetterPlayerWidget extends StatefulWidget {
  final String currentVideoUrl;
  final double videoHgiht;
  final double videoWidth;

  const BetterPlayerWidget({
    super.key,
    required this.currentVideoUrl,
    required this.videoHgiht,
    required this.videoWidth,
  });

  @override
  State<BetterPlayerWidget> createState() => _ReelsVideoWidgetState();
}

class _ReelsVideoWidgetState extends State<BetterPlayerWidget> {
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
        // aspectRatio: 9 / 16,
        fit: BoxFit.fill,
        autoPlay: true,
        looping: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: true,
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
    });
  }

  @override
  void didUpdateWidget(covariant BetterPlayerWidget oldWidget) {
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
        : SizedBox(
            height: widget.videoHgiht, // Set your height
            width: widget.videoWidth, // Set your width
            child: BetterPlayer(controller: _betterPlayerController));
  }
}
