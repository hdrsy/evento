
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/reels/controller/reels_controller.dart';
import 'package:evento/features/reels/model/reels_model.dart';
import 'package:evento/features/reels/view/widgets/reel_component/comment_like_share.dart';
import 'package:evento/features/reels/view/widgets/reel_component/follow_button.dart';
import 'package:evento/features/reels/view/widgets/reel_component/number_of_showing.dart';
import 'package:evento/features/reels/view/widgets/reel_component/reels_shimmer.dart';
import 'package:evento/features/reels/view/widgets/reel_component/user_name.dart';
import 'package:evento/features/reels/view/widgets/reel_component/user_photo.dart';
import 'package:evento/core/shared/widgets/video/reels_video_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelsWidget extends StatelessWidget {
  ReelsWidget({super.key, required this.model});
  
  final ReelModel model;

  final ReelsController reelsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: screenWidth,
        height: MediaQuery.of(context).size.height * 0.9,
        child: 
        Obx(
          ()=> reelsController.isLoading.value? const ReelsShimmer(): 
          
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
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
                            ReelsVideoWidget(
                              currentVideoUrl:"${ServerConstApis.baseAPI}/storage/${ model.videos[0]}",
                            ),
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
              description(model.description),
              videInfoDataAndNumberViews(model),
            ],
          ),
        ),
      ],
    );
  }
}

Row videInfoDataAndNumberViews(ReelModel model) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      numberOfShowing(),
      reelDate(DateFormatter.formatDate(model.createdAt)),
    ].divide(const SizedBox(width: 10)),
  );
}

Align description(String description) {
  return Align(
    alignment: const AlignmentDirectional(-1.00, 1.00),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
      child: Text(
        description,
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

Text reelDate(String reelDate) {
  return Text(
    reelDate,
    style: customTextStyle.bodyMedium.override(
      fontFamily: 'Nunito',
      color: customColors.primaryText,
      fontSize: 12,
      useGoogleFonts: true,
    ),
  );
}

// ignore: camel_case_types
class userPhotoAndName extends StatelessWidget {
  const userPhotoAndName({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ReelModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        userPhoto(),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
          child: userName(model.user!=null?model.user!.firstName:"Evento"),
        ),
      ],
    );
  }
}

// void handleVideoTap(
//     TapUpDetails details, VideoPlayerController videoPlayerController) {
//   double localscreenWidth = screenWidth;
//   double tappedPosition = details.globalPosition.dx;
//   ReelsController reelsController = Get.find();

//   if (videoPlayerController == null) {
//     return; // Exit if playerController is not initialized
//   }
//   if (tappedPosition > localscreenWidth * 0.75) {
//     log("right tap");
//     // Right side tapped
//     reelsController.nextVideo();
//   } else if (tappedPosition < localscreenWidth * 0.25) {
//     // Left side tapped
//     reelsController.previousVideo();
//   } else {
//     // Center tapped, toggle play/pause
//     if (videoPlayerController.value.isPlaying) {
//       videoPlayerController.pause();
//     } else {
//       videoPlayerController.play();
//     }
//   }
// }
