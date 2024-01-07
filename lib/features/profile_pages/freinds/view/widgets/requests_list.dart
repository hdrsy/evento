import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/shared/widgets/widget/users_shimmer_card.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/freinds/controller/freinds_cotroller.dart';
import 'package:evento/features/profile_pages/freinds/model/recive_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestsList extends StatelessWidget {
  const RequestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FreindsController>(builder: (controller) {
      return SingleChildScrollView(
        child: controller.isRecivedFreindsLoading.value?ShimmerLoadingWidget(loadingShimmerWidget: ShimmerFriendCard()):
        
        
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Friend requests ",
                          style: TextStyle(
                            color: customColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: controller.recivedFreinds.length.toString(),
                          style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: true,
                          ),
                        ),
                      ],
                      style: customTextStyle.bodyMedium,
                    ),
                  ),
                  Text(
                    "see all",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primary,
                      fontSize: 12,
                      useGoogleFonts: false,
                    ),
                  ),
                ],
              ),
            ),
          
            ...List.generate(controller.recivedFreinds.length,
                (index) =>  RequestsCard(receiveRequest:controller.recivedFreinds[index] ,modelId: index,))
          ].divide(const SizedBox(
            height: 10,
          )),
        ),
      );
    });
  }
}

class RequestsCard extends StatelessWidget {
  const RequestsCard(
      {super.key, required this.receiveRequest, required this.modelId});
  final ReceiveRequest receiveRequest;
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
                    child: receiveRequest.sender.image.length > 6
                          ?getImageNetwork(
                              url: "/storage/${receiveRequest.sender.image}",
                              width: 90,
                              height: 90)
                          : Image.asset(
                              'assets/images/${receiveRequest.sender.image}.png')
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${receiveRequest.sender.firstName} ${receiveRequest.sender.lastName}",
                            style: customTextStyle.bodyLarge,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonWidget(
                                onPressed: () {
                                 final FreindsController freindsController=Get.find();
                                 freindsController.confirmRecivedRequest(receiveRequest.senderId, modelId);
                                },
                                text: "Confirm",
                                options: ButtonOptions(
                                  width: 120,
                                  height: 21,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: customColors.primary,
                                  textStyle:
                                      customTextStyle.titleSmall.override(
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
                              ),
                              ButtonWidget(
                                onPressed: () {
                                                                   final FreindsController freindsController=Get.find();
                                 freindsController.deleteRecivedRequest(receiveRequest.senderId, modelId);
                               
                                },
                                text: "Delete",
                                options: ButtonOptions(
                                  width: 120,
                                  height: 21,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: customColors.secondaryBackground,
                                  textStyle:
                                      customTextStyle.titleSmall.override(
                                    fontFamily: 'Nunito',
                                    color: customColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                  ),
                                  borderSide: BorderSide(
                                    color: customColors.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ].divide(const SizedBox(height: 10)),
                      ),
                    ),
                  ),
              
              
                ],
              )),
        ),
      ),
    );
  }
}
