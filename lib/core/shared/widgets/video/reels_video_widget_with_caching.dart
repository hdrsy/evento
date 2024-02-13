// import 'package:better_player/better_player.dart';
// import 'package:evento/core/shared/controllers/tween_animation_controller.dart';
// import 'package:evento/features/reels/controller/reels_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ReelsVideoWidgetWitCaching extends StatefulWidget {
//   final String currentVideoUrl;
//   final int videoIndex;
//   final int modelIndex;
//   final int totalVideos;
//   final ReelsController reelsController = Get.find();
//   final TweenAnimationController tweenAnimationController =
//       Get.put(TweenAnimationController());

//   ReelsVideoWidgetWitCaching({
//     super.key,
//     required this.currentVideoUrl,
//     required this.videoIndex,
//     required this.totalVideos,
//     required this.modelIndex,
//   });

//   @override
//   State<ReelsVideoWidgetWitCaching> createState() => _ReelsVideoWidgetState();
// }

// class _ReelsVideoWidgetState extends State<ReelsVideoWidgetWitCaching> {
//   late BetterPlayerController _betterPlayerController;
//   late BetterPlayerDataSource _dataSource;

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }

//   void _initializePlayer() {
//     _dataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       widget.currentVideoUrl,
//       cacheConfiguration: const BetterPlayerCacheConfiguration(
//         useCache: true,
//         maxCacheSize: 100 * 1024 * 1024, // e.g., 100MB
//         maxCacheFileSize: 10 * 1024 * 1024, // e.g., 10MB for each file
//       ),
//     );
//     _betterPlayerController = BetterPlayerController(
//       const BetterPlayerConfiguration(
//         aspectRatio: 9 / 16,
//         fit: BoxFit.cover,
//         autoPlay: true,
//         looping: false,
//         controlsConfiguration: BetterPlayerControlsConfiguration(
//           showControls: false,
//         ),
//       ),
//       betterPlayerDataSource: _dataSource,
//     );

//     _betterPlayerController.addEventsListener((event) {
//       if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
//         widget.reelsController
//             .playNextVideo(widget.modelIndex, widget.videoIndex);
//       }
//     });
//   }

//   @override
//   void didUpdateWidget(covariant ReelsVideoWidgetWitCaching oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.currentVideoUrl != oldWidget.currentVideoUrl) {
//       _betterPlayerController.pause();
//       _betterPlayerController.dispose();
//       _initializePlayer();
//     }
//   }

//   @override
//   void dispose() {
//     _betterPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 9 / 16,
//       child: BetterPlayer(controller: _betterPlayerController),
//     );
//   }
// }
