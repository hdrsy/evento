import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/shared/widgets/buttons/general_button.dart';
import '../../../core/shared/widgets/images/network_image.dart';
import '../../../core/utils/animation/shimmer_animation.dart';
import '../../../core/utils/helper/flutter_flow_util.dart';
import '../../../core/utils/theme/text_theme.dart';
import '../controller/going_controller.dart';
import '../model/going_model.dart';
import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class GoingScreen extends StatelessWidget {
  GoingScreen({super.key});
  final GoingController goingController = Get.put(GoingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text(tr("Going"),
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: InkWell(
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
        body: Obx(
          () => goingController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: customColors.primary,
                  ),
                )
              : 
               
            goingController.itemList.isEmpty?const EmptyData(icon:Icons.people_rounded ,message:"It looks like no one has confirmed attendance yet. Be the first to join!" ,):
            
              
              SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  controller: goingController.scrollController,
                  child: Column(
                    children: [
                      ...List.generate(
                          goingController.hasMoreData.value
                              ? goingController.itemList.length + 1
                              : goingController.itemList.length, (index) {
                        return index < goingController.itemList.length
                            ? GoingCard(
                                goingModel: goingController.itemList[index],
                                modelId: index,
                              )
                            : ShimmerLoadingWidget(
                                loadingShimmerWidget: Container(
                                width: double.infinity,
                                height: screenHeight * 0.1,
                                // height: 330 ,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: customColors.info,
                                    ),
                                    color: customColors.info),
                              ));
                      })
                    ].divide(const SizedBox(
                      height: 10,
                    )),
                  ),
                ),
        ));
  }
}

class GoingCard extends StatelessWidget {
  const GoingCard({super.key, required this.goingModel, required this.modelId});
  final GoingModel goingModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoingController>(builder: (context) {
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
                      child: goingModel.image.length > 6
                ? getImageNetwork(
                    url: "/storage/${goingModel.image}",
                    width: 90 ,
                    height: 90)
                : Image.asset(
                    'assets/images/${goingModel.image}.png',width: 90,height: 90,)),
        
                    
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${goingModel.firstName} ${goingModel.lastName}",
                              style: customTextStyle.bodyLarge,
                            ),
                            userState(
                                goingModel, modelId)
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

  Widget userState( GoingModel goingModel, int modelId) {
    if (goingModel.friendRequestStatus == null) {
      return AddFriendButton(
        userId: goingModel.id,
        modelId: modelId,
      );
    } else {
      return goingModel.friendRequestStatus == "pending"
          ? CancelButton(requestId: goingModel.id, modelId: modelId)
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
        GoingController goingController = Get.find();
        goingController.onPressAddFreind(userId, modelId);
      },
      text:tr( "Add friend"),
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
  const CancelButton({super.key, required this.requestId, required this.modelId});
  final int requestId;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    print("onside cancel");
    return ButtonWidget(
      onPressed: () {
        GoingController goingController = Get.find();
        goingController.onPressCancelReques(requestId, modelId);
      },
      text:tr( "Cancel"),
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
