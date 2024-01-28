import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/shared/widgets/widget/users_shimmer_card.dart';
import '../../../../../core/utils/animation/shimmer_animation.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/freinds_cotroller.dart';
import '../../model/freinds_model.dart';
import 'un_friend_widget.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class FreindsList extends StatelessWidget {
  FreindsList({super.key});
  final FreindsController freindsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FreindsController>(builder: (ccontext) {
      return freindsController.isMyFriendsLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: customColors.primary,
              ),
            )
          : freindsController.myFreinds.isEmpty
              ? const EmptyData(
                  icon: Icons.person_add,
                  message:
                      "Your friends list is looking a bit lonely. Go ahead and connect with people!",
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: tr("Friends "),
                                    style: TextStyle(
                                      color: customColors.primaryText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: freindsController.myFreinds.length
                                        .toString(),
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
                            // Text(
                            //   "Manage",
                            //   style: customTextStyle.bodyMedium.override(
                            //     fontFamily: 'Nunito',
                            //     color: customColors.primary,
                            //     fontSize: 12,
                            //     useGoogleFonts: false,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      ...List.generate(
                          freindsController.myFreinds.length,
                          (index) => FreindsCard(
                                freindsModel:
                                    freindsController.myFreinds[index],
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

class FreindsCard extends StatelessWidget {
  const FreindsCard(
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
                InkWell(
                  onTap: () {
                    showButtonSheet(
                        context: context,
                        widget: UnfriendWidget(
                            freindsModel: freindsModel, modelId: modelId),
                        height: screenHeight * 0.1);
                  },
                  child: Icon(
                    Icons.keyboard_control_sharp,
                    color: customColors.secondaryText,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
