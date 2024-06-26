import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/features/organizer/organizer_profile/model/organizer_profile_followers_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OrganizationFolloersCard extends StatelessWidget {
  const OrganizationFolloersCard(
      {super.key, required this.organizerFollowersModel});
  final OrganizerFollowersModel organizerFollowersModel;
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
        ],
      ),
    );
  }
}
