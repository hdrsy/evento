import 'package:easy_localization/easy_localization.dart';

import '../../../core/shared/widgets/images/network_image.dart';
import '../../../core/utils/helper/flutter_flow_util.dart';
import '../controller/assign_friends_controller.dart';
import '../../profile_pages/freinds/model/freinds_model.dart';
import '../../../main.dart';
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Column(
            children: [
              ...List.generate(
                  assignFriendsController.myFreinds.length,
                  (index) => AssignFreindCard(
                        freindsModel: assignFriendsController.myFreinds[index],
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
                    child: Text("Assign")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
