import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/freinds_cotroller.dart';
import '../../model/recive_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class RequestsList extends StatelessWidget {
  const RequestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FreindsController>(builder: (controller) {
      return controller.isRecivedFreindsLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: customColors.primary,
              ),
            )
          : controller.isRecivedFreindsError.value
              ? EmptyData(
                  icon: Icons.error_outline_outlined,
                  message: "SomeThing Wrong!!",
                )
              : controller.recivedFreinds.isEmpty
                  ? EmptyData(
                      onTap: () {
                        Get.toNamed('/AddFriendsScreen');
                      },
                      icon: Icons.person,
                      message:
                          "No new friend requests. Send out some invites to get connected!",
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 0, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: tr("Friend requests"),
                                        style: TextStyle(
                                          color: customColors.primaryText,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: controller.recivedFreinds.length
                                            .toString(),
                                        style:
                                            customTextStyle.bodyMedium.override(
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
                              ],
                            ),
                          ),
                          ...List.generate(
                              controller.recivedFreinds.length,
                              (index) => RequestsCard(
                                    receiveRequest:
                                        controller.recivedFreinds[index],
                                    modelId: index,
                                  ))
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
                          ? getImageNetwork(
                              url: "/storage/${receiveRequest.sender.image}",
                              width: 90,
                              height: 90)
                          : Image.asset(
                              'assets/images/${receiveRequest.sender.image}.png')),
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
                                  final FreindsController freindsController =
                                      Get.find();
                                  freindsController.confirmRecivedRequest(
                                      receiveRequest.senderId, modelId);
                                },
                                text: tr("Confirm"),
                                options: ButtonOptions(
                                  width: 120.w,
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
                                  final FreindsController freindsController =
                                      Get.find();
                                  freindsController.deleteRecivedRequest(
                                      receiveRequest.senderId, modelId);
                                },
                                text: tr("Delete"),
                                options: ButtonOptions(
                                  width: 120.w,
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
