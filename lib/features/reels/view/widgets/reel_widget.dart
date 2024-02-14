// import 'package:evento/core/shared/widgets/video/reels_video_widget_with_caching.dart';

import 'package:evento/core/colors/app_colors.dart';
import 'package:evento/core/shared/widgets/video/reels_video_listview.dart';
import 'package:evento/core/shared/widgets/video/reels_video_widget_with_caching.dart';
import 'package:intl/number_symbols_data.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/helper/date_formatter.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../controller/reels_controller.dart';
import '../../model/reels_model.dart';
import 'reel_component/comment_like_share.dart';
import 'reel_component/follow_button.dart';
import 'reel_component/number_of_showing.dart';
import 'reel_component/reels_shimmer.dart';
import 'reel_component/user_name.dart';
import 'reel_component/user_photo.dart';
import '../../../../core/shared/widgets/video/reels_video_widget.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelsWidget extends StatelessWidget {
  ReelsWidget({super.key, required this.model, required this.modelIndex});

  final ReelModel model;
  final int modelIndex;

  final ReelsController reelsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: screenWidth,
        // height: MediaQuery.of(context).size.height,
        child: Obx(
          () => reelsController.isLoading.value
              ? const ReelsShimmer()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            MultiVideoPlayer(
                                videos: model.videos,
                                eventId: model.id,
                                modelId: modelIndex),
                            videoInfo(),
                            commentShareLike(modelIndex),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                    model.event != null
                        ? followButton(modelIndex)
                        : SizedBox.shrink(),
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
      // numberOfShowing(),
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
      color: AppColors.darkPrimary,
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
        userPhoto(model),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
          child: userName(getReelToname(model)),
        ),
      ],
    );
  }
}

String getReelToname(ReelModel model) {
  if (model.event != null) {
    return model.event!.title;
  } else if (model.user != null) {
    return model.user!.firstName;
  } else if (model.venue != null) {
    return model.venue!.name;
  } else {
    return "Evento";
  }
}
