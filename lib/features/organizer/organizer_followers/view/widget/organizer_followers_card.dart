import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/features/organizer/organizer_followers/controller/organizer_followers_controller.dart';
import 'package:evento/features/organizer/organizer_profile/model/organizer_profile_followers_model.dart';
import 'package:get/get.dart';

import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OrganizerFollowersCard extends StatelessWidget {
  const OrganizerFollowersCard(
      {super.key,
      required this.organizerFollowersModel,
      required this.modelId});
  final OrganizerFollowersModel organizerFollowersModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return // Generated code for this Row Widget...
        Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: organizerFollowersModel.profile!.length > 6
                  ? getImageNetwork(
                      url: "/storage/${organizerFollowersModel.profile}",
                      width: 90,
                      height: 90)
                  : Image.asset(
                      'assets/images/${organizerFollowersModel.profile}.png',
                      width: 90,
                      height: 90)),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Text(
                "${organizerFollowersModel.firstName} ${organizerFollowersModel.lastName}",
                style: customTextStyle.bodyLarge,
              ).tr(),
            ),
          ),
          userState(organizerFollowersModel, modelId)
        ],
      ),
    );
  }

  Widget userState(OrganizerFollowersModel goingModel, int modelId) {
    if (goingModel.friendRequestStatusWithAuthUser == null) {
      return AddFriendButton(
        userId: goingModel.id!,
        modelId: modelId,
      );
    } else {
      return goingModel.friendRequestStatusWithAuthUser == "pending"
          ? CancelButton(requestId: goingModel.id!, modelId: modelId)
          : const SizedBox();
    }
  }
}

class AddFriendButton extends StatelessWidget {
  const AddFriendButton(
      {super.key, required this.userId, required this.modelId});
  final int userId;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onPressed: () {
        OrganizerFollowersController goingController = Get.find();
        goingController.onPressAddFreind(userId, modelId);
      },
      text: tr("Add friend"),
      options: ButtonOptions(
        width: 120,
        height: 21,
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.primary,
        textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          color: customColors.info,
          fontSize: 10,
          fontWeight: FontWeight.normal,
          useGoogleFonts: true,
        ),
        borderSide: BorderSide(
          color: customColors.primary,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton(
      {super.key, required this.requestId, required this.modelId});
  final int requestId;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onPressed: () {
        OrganizerFollowersController goingController = Get.find();
        goingController.onPressCancelReques(requestId, modelId);
      },
      text: tr("Cancel"),
      options: ButtonOptions(
        width: 120,
        height: 25,
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.secondaryBackground,
        textStyle: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          color: customColors.primary,
          fontSize: 10,
          fontWeight: FontWeight.normal,
          useGoogleFonts: true,
        ),
        borderSide: BorderSide(
          color: customColors.primary,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
