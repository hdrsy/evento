import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/reels/controller/reels_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget commentShareLike() {
  ReelsController reelsController=Get.find();
    return GetBuilder<ReelsController>(
      builder: (context) {
        return Align(
          alignment: const AlignmentDirectional(1.00, -1.00),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleIcon(
                      onPressed: () async {
                        // bool isVedioliked= reelsController.itemList[reelsController.currentUserIndex].videos[reelsController.currentVideoIndex].isLiked;
                        // reelsController.videoList[reelsController.currentUserIndex].videos[reelsController.currentVideoIndex].isLiked=! isVedioliked;
                        // reelsController.update();
                      },
                      // value: reelsController.itemList[reelsController.currentUserIndex].videos[0].isLiked,
                      value: false,
                      onIcon: Icon(
                        Icons.favorite_rounded,
                        color: customColors.error,
                        size: 30,
                      ),
                      offIcon:  Icon(
                        Icons.favorite_border_sharp,
                        color: customColors.info,
                        size: 30,
                      ),
                    ),
                    Text(
                      "2.6k",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.info,
                        useGoogleFonts: true,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(
                      Icons.insert_comment_outlined,
                      color: customColors.info
                      ,
                      size: 30,
                    ),
                    Text(
                      "200",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.info,
                        useGoogleFonts: true,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(
                      Icons.reply_outlined,
                      color: customColors.info,
                      size: 30,
                    ),
                    Text(
                      "12",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.info,
                        useGoogleFonts: true,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ].divide(const SizedBox(height: 10,)),
          ),
        );
      }
    );
  }

  