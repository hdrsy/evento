import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/utils/animation/animation_def.dart';
import '../../../../../core/utils/animation/animation_util.dart';
import '../../../steps/controller/steps_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildAvatarList(
  context,
) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.arrow_drop_down,
          color: customColors.primary,
          size: 24,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 6),
          child: singleElementAvatar(
            context,
          ),
        ),
        Icon(
          Icons.arrow_drop_up,
          color: customColors.primary,
          size: 24,
        ),
      ],
    ),
  );
}

Widget singleElementAvatar(
  context,
) {
  StepsController stepsController = Get.find();
  int initialPage = stepsController.avatarList.length ~/ 2;

  return Obx(
    () => SizedBox(
        height: scaleHeight(60),
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: stepsController.avatarList.length,
          itemBuilder: (context, index, realIdx) {
            return Container(
              width: scaleWidth(60),
              height: scaleWidth(60),
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                
                // borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: _getImageProvider(stepsController.avatarList[index]),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 24,
                    color: customColors.shadow,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            autoPlay:
                false, // Set to false so users can see all images without autoplay
            enlargeCenterPage:
                true, // Set to false to keep all images the same size
            aspectRatio: 16 / 9,
            enableInfiniteScroll:
                false, // Set to false to stop looping after the last image
            viewportFraction: 0.2, // Adjust to fit more items on the screen
            initialPage: initialPage,
            onPageChanged: (index, reason) {
              stepsController.selectedProfileindex=index;
            },
          ),
        ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation']!),
        
        ),
  );
}

ImageProvider _getImageProvider(dynamic item) {
  if (item is File) {
    return FileImage(item);
  } else if (item is String) {
    return AssetImage(item);
  } else {
    throw Exception('Unknown type in avatar list');
  }
}
