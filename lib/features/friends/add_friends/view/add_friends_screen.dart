import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/utils/theme/text_theme.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/images/network_image.dart';
import '../../../../core/shared/widgets/text_fields/search_filed.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
// import '../../../going/view/going_screen.dart';
import '../controller/add_friends_controller.dart';
import '../model/add_friends_model.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class AddFriendsScreen extends StatelessWidget {
  final AddFriendsController addFriendsController =
      Get.put(AddFriendsController());

  AddFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          surfaceTintColor: customColors.secondaryBackground,
          backgroundColor: customColors.secondaryBackground,
          title: Text(tr("Add Friends"),
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_rounded,
              color: customColors.primaryText,
              size: 30,
            ),
          ),
        ),
        body: Obx(
          () => (addFriendsController.isLoading.value &&
                  addFriendsController.itemList.isEmpty)
              ?
              // Show loading indicator while initial data is loading
              const Center(child: CircularProgressIndicator())
              : addFriendsController.isError.value
                  ? EmptyData(
                      icon: Icons.error_outline_outlined,
                      message: "SomeThing Wrong!!",
                    )
                  : SingleChildScrollView(
                      controller: addFriendsController.scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        children: [
                          searchTextField(
                            controller: addFriendsController.friendsSearch,
                            onChanged: (value) {
                              // Search logic is handled by the controller
                            },
                          ),
                          const SizedBox(height: 15),
                          ...List.generate(
                            addFriendsController.itemList.length +
                                (addFriendsController.hasMoreData.value
                                    ? 1
                                    : 0),
                            (index) {
                              if (index >=
                                  addFriendsController.itemList.length) {
                                // If hasMoreData is false, don't show the ShimmerFriendCard
                                return addFriendsController.hasMoreData.value
                                    ? Container()
                                    : Container();
                              } else {
                                // Return the actual friend card for this index
                                return AddFriendCard(
                                  addFriendsModel:
                                      addFriendsController.itemList[index],
                                  modelId: index,
                                );
                              }
                            },
                          ).toList(),
                          if (addFriendsController.isLoadingMoreData.value)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        ],
                      ),
                    ),
        ));
  }
}

class AddFriendCard extends StatelessWidget {
  const AddFriendCard(
      {super.key, required this.addFriendsModel, required this.modelId});
  final AddFriendsModel addFriendsModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFriendsController>(builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
          child: Container(
            width: screenHeight * 0.15,
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
                        child: addFriendsModel.image.length > 6
                            ? getImageNetwork(
                                url: "/storage/${addFriendsModel.image}",
                                width: 90,
                                height: 90)
                            : Image.asset(
                                'assets/images/${addFriendsModel.image}.png',
                                width: 90,
                                height: 90,
                              )),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${addFriendsModel.firstName} ${addFriendsModel.lastName}",
                              style: customTextStyle.bodyLarge,
                            ),
                            FreindStateWidget(addFriendsModel, modelId)
                          ].divide(const SizedBox(height: 10)),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }
}

Widget FreindStateWidget(AddFriendsModel addFriendsModel, int modelId) {
  if (addFriendsModel.friendRequestStatus == null) {
    return AddFriendButton(
      userId: addFriendsModel.id,
      modelId: modelId,
    );
  } else {
    return addFriendsModel.friendRequestStatus == "pending"
        ? CancelButton(requestId: addFriendsModel.id, modelId: modelId)
        : const SizedBox();
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
        AddFriendsController addFriendsController = Get.find();
        addFriendsController.onPressAddFreind(userId, modelId);
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
        AddFriendsController addFriendsController = Get.find();
        addFriendsController.onPressCancelReques(requestId, modelId);
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
