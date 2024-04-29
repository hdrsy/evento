import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/friends/freinds/model/freinds_model.dart';
import 'package:evento/main.dart';

import '../controller/assign_friends_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignFriendsScreen extends StatelessWidget {
  AssignFriendsScreen({super.key});
  final AssignFriendsController assignFriendsController =
      Get.put(AssignFriendsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          surfaceTintColor: customColors.secondaryBackground,
          backgroundColor: customColors.secondaryBackground,
          title: Text(tr("My Freinds"),
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: customColors.primaryText,
              size: 30,
            ),
          ),
        ),
        body: assignFriendsController.myFreinds.isEmpty
            ? EmptyData(
                onTap: () {
                  Get.toNamed('/AddFriendsScreen');
                },
                icon: Icons.person_add,
                message:
                    "It looks like your friends list is empty, Use the search bar above to find and connect with friends",
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Column(
                  children: [
                    ...List.generate(
                        assignFriendsController.myFreinds.length,
                        (index) => AssignFreindCard(
                              freindsModel:
                                  assignFriendsController.myFreinds[index],
                              modelId: index,
                            ))
                  ].divide(const SizedBox(
                    height: 10,
                  )),
                ),
              ));
  }
}

class AssignFreindCard extends StatelessWidget {
  const AssignFreindCard(
      {super.key, required this.freindsModel, required this.modelId});
  final FreindsModel freindsModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: freindsModel.image.length > 6
                      ? getImageNetwork(
                          url: "/storage/${freindsModel.image}",
                          width: 90,
                          height: 90)
                      : Image.asset(
                          'assets/images/${freindsModel.image}.png',
                          width: 90,
                          height: 90,
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      "${freindsModel.firstName} ${freindsModel.lastName}",
                      style: customTextStyle.bodyLarge,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      AssignFriendsController assignFriendsController =
                          Get.find();
                      assignFriendsController.onPressFillFriendData(modelId);
                    },
                    child: Text(
                      "Assign",
                      style: customTextStyle.bodyMedium
                          .copyWith(color: customColors.primary),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
