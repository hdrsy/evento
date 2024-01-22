import 'package:share_plus/share_plus.dart';

import '../../../../../core/shared/widgets/buttons/toggle_icon.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../controller/reels_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget commentShareLike(int modelIndex) {
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
                        print("dddddd");
                      reelsController. followOrUnFollowEvent(reelsController.itemList[modelIndex].id,modelIndex);
                      },
                      // value: reelsController.itemList[reelsController.currentUserIndex].videos[0].isLiked,
                      value: reelsController.itemList[modelIndex].likedByUser,
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
                      reelsController.itemList[modelIndex].likesCount.toString(),
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
              // Container(
              //   decoration: const BoxDecoration(),
              //   child: Column(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //        Icon(
              //         Icons.insert_comment_outlined,
              //         color: customColors.info
              //         ,
              //         size: 30,
              //       ),
              //       Text(
              //         "200",
              //         style: customTextStyle.bodyMedium.override(
              //           fontFamily: 'Nunito',
              //           color: customColors.info,
              //           useGoogleFonts: true,
              //           fontSize: 16
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
        
              GestureDetector(
                onTap: ()async{
            const String message = "Check out this event in Evento";
          final String url = "http://94.141.219.16:8003/#/eventDetailes/";  // Replace with your event link
          final String shareContent = "$message\n\nFor more details, visit: $url";

        await   Share.share(shareContent);
                 
                },
                child: Container(
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
                      // Text(
                      //   "12",
                      //   style: customTextStyle.bodyMedium.override(
                      //     fontFamily: 'Nunito',
                      //     color: customColors.info,
                      //     useGoogleFonts: true,
                      //     fontSize: 16
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ].divide(const SizedBox(height: 10,)),
          ),
        );
      }
    );
  }

  