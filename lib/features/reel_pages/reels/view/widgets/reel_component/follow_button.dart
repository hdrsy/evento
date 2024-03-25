import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/colors/app_colors.dart';

import 'package:evento/features/reel_pages/reels/controller/reels_controller.dart';
import 'package:get/get.dart';

import '../../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';

Widget followButton(int modelIndex) {
  final ReelsController reelsController = Get.find();
  return GetBuilder<ReelsController>(builder: (context) {
    return ButtonWidget(
      onPressed: () {
        reelsController.followOrUnFollowreelEvent(
            reelsController.itemList[modelIndex].event!.id, modelIndex);
      },
      text: reelsController.itemList[modelIndex].event!.isFollowedByAuthUser
          ? tr("Following")
          : tr("Follow"),
      options: ButtonOptions(
        width: 85,
        height: 31,
        color: reelsController.itemList[modelIndex].event!.isFollowedByAuthUser
            ? AppColors.darkSecondaryBackground
            : AppColors.darkSecondaryBackground,
        textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          useGoogleFonts: true,
          color:
              reelsController.itemList[modelIndex].event!.isFollowedByAuthUser
                  ? customColors.primary
                  : customColors.info,
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        borderSide: BorderSide(
          color: customColors.primaryBackground,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  });
}
