// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/controllers/tween_animation_controller.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/reels/controller/reels_controller.dart';
import 'package:evento/features/reels/controller/video_controller.dart';
import 'package:evento/features/reels/model/reels_model.dart';
import 'package:evento/features/reels/view/widgets/reel_component/comment_like_share.dart';
import 'package:evento/features/reels/view/widgets/reel_component/follow_button.dart';
import 'package:evento/features/reels/view/widgets/reel_component/number_of_showing.dart';
import 'package:evento/features/reels/view/widgets/reel_component/reels_shimmer.dart';
import 'package:evento/features/reels/view/widgets/reel_component/user_name.dart';
import 'package:evento/features/reels/view/widgets/reel_component/user_photo.dart';
import 'package:evento/main.dart';

// ignore: must_be_immutable
class ReelWidget extends StatelessWidget {
  ReelWidget({
    super.key,
    required this.model,
  });
  final RR model;
  final ReelsController reelsController = Get.find();
  final TweenAnimationController tweenAnimationController =
      Get.put(TweenAnimationController());
  VideoController videoController = Get.find();
  // bool showHeartIcon = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(builder: (ccontext) {
      if (videoController.playerController == null) {
        return const ReelsShimmer(); // or any other placeholder
      }
      return GestureDetector(
        onDoubleTap: onDoubleTap,
        onTapUp: (details) {
          // Implement the logic to play/pause video based on tap position
          handleVideoTap(details, videoController);
        },
        child: SizedBox(
          width: screenWidth,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildProgressIndecator(),
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: customColors.secondaryBackground,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [reelsVideoPlayer()],
                            ),
                            //to show pause icon when it the video puased.
                            if (!videoController
                                .playerController!.value.isPlaying)
                              const Center(
                                  child: Icon(Icons.play_arrow,
                                      size: 50.0, color: Colors.white)),

                            //to make the heart appear in the midle of the screen when I double tap on it.
                            tweenAnimationController.aSize.value! > 30
                                ? Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Icon(Icons.favorite,
                                        size: tweenAnimationController
                                            .aSize.value,
                                        color: Colors.red),
                                  )
                                : const SizedBox(),
                            videoInfo(),
                            commentShareLike(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  SizedBox buildProgressIndecator() {
    return SizedBox(
              height: 50,
              child: Row(
                children: model.videos
                    .asMap()
                    .entries
                    .map((entry) {
                      return Expanded(
                          child: videoProgressIndicator(entry.key));
                    })
                    .toList()
                    .divide(const SizedBox(
                      width: 5,
                    )),
              ),
            );
  }

  Column videoInfo() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: const AlignmentDirectional(1.00, -1.00),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    userPhotoAndName(model: model),
                    followButton(),
                  ].divide(const SizedBox(width: 10)),
                ),
              ),
              description(),
              videInfoDataAndNumberViews(),
            ],
          ),
        ),
      ],
    );
  }

  Visibility reelsVideoPlayer() {
    return Visibility(
      visible: videoController.videoInitialized,
      replacement: Center(
          child: CircularProgressIndicator(color: customColors.primaryText)),
      child: AspectRatio(
        aspectRatio: videoController.playerController!.value.aspectRatio,
        child: VideoPlayer(videoController.playerController!),
      ),
    );
  }

  Row videInfoDataAndNumberViews() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        numberOfShowing(),
        reelDate(),
      ].divide(const SizedBox(width: 10)),
    );
  }

  Align description() {
    return Align(
      alignment: const AlignmentDirectional(-1.00, 1.00),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
        child: Text(
          "Festival of Arts",
          style: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            color: Colors.white,
            fontSize: 16,
            useGoogleFonts: true,
          ),
        ),
      ),
    );
  }

  Widget videoProgressIndicator(int index) {
    return GetBuilder<VideoController>(
      builder: (controller) {
        double progress = (controller.currentVideoIndex == index)
            ? controller.currentProgress
            : 0.0;
        return LinearProgressIndicator(
          value: progress,
          semanticsLabel: progress.toString(),
          backgroundColor: Colors.grey, // Background color of the progress bar
          valueColor:
              AlwaysStoppedAnimation<Color>(customColors.primary), // Fill color
        );
      },
    );
  }

  Text reelDate() {
    return Text(
      "30-10-2023",
      style: customTextStyle.bodyMedium.override(
        fontFamily: 'Nunito',
        color: customColors.primaryText,
        fontSize: 12,
        useGoogleFonts: true,
      ),
    );
  }

  void onDoubleTap() {
    if (tweenAnimationController.aColor.value == Colors.red) {
      tweenAnimationController.aController.reverse();
    } else {
      tweenAnimationController.aController.forward();
    }

    reelsController.videoList[reelsController.currentUserIndex]
        .videos[reelsController.currentVideoIndex].isLiked = true;
  }
}

// ignore: camel_case_types
class userPhotoAndName extends StatelessWidget {
  const userPhotoAndName({
    Key? key,
    required this.model,
  }) : super(key: key);

  final RR model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        userPhoto(),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
          child: userName(model.userName),
        ),
      ],
    );
  }
}

void handleVideoTap(TapUpDetails details, VideoController videoController) {
  double localscreenWidth = screenWidth;
  double tappedPosition = details.globalPosition.dx;
  if (videoController.playerController == null) {
    return; // Exit if playerController is not initialized
  }
  if (tappedPosition > localscreenWidth * 0.75) {
    log("right tap");
    // Right side tapped
    videoController.nextVideo();
  } else if (tappedPosition < localscreenWidth * 0.25) {
    // Left side tapped
    videoController.previousVideo();
  } else {
    // Center tapped, toggle play/pause
    if (videoController.playerController!.value.isPlaying) {
      videoController.pauseVideo();
    } else {
      videoController.playVideo();
    }
  }
}
