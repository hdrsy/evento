import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/friends/freinds/model/freinds_model.dart';
import 'package:evento/main.dart';

import '../controller/invite_freind_to_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class InviteFreindsToEventScreen extends StatelessWidget {
  InviteFreindsToEventScreen({super.key});
  final InviteFreindsToEventController inviteFreindsToEventController =
      Get.put(InviteFreindsToEventController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        surfaceTintColor: customColors.secondaryBackground,
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Invite"),
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
      body: Obx(
        () => inviteFreindsToEventController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: customColors.primary,
                ),
              )
            : inviteFreindsToEventController.isError.value
                ? EmptyData(
                    icon: Icons.error_outline_outlined,
                    message: "SomeThing Wrong!!",
                  )
                : inviteFreindsToEventController.myFreinds.isEmpty
                    ? EmptyData(
                        icon: Icons.person_add,
                        message:
                            "Your friends list is looking a bit lonely. Go ahead and connect with people!",
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Column(
                          children: [
                            // searchTextField(onChanged: (c) {}),
                            ...List.generate(
                                inviteFreindsToEventController.myFreinds.length,
                                (index) => InviteFreindsCard(
                                      freindsModel:
                                          inviteFreindsToEventController
                                              .myFreinds[index],
                                      modelIndex: index,
                                    ))
                          ].divide(const SizedBox(
                            height: 10,
                          )),
                        ),
                      ),
      ),
    );
  }
}

class InviteFreindsCard extends StatelessWidget {
  const InviteFreindsCard(
      {super.key, required this.freindsModel, required this.modelIndex});
  final FreindsModel freindsModel;
  final int modelIndex;
  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "${freindsModel.firstName} ${freindsModel.lastName}",
                    style: customTextStyle.bodyLarge.override(
                        fontSize: 16,
                        fontFamily: secondaryFontFamily,
                        useGoogleFonts: true),
                  ),
                  const Spacer(),
                  GetBuilder<InviteFreindsToEventController>(
                      builder: (controller) {
                    return ButtonWidget(
                      onPressed: () {
                        controller.onPressInviteFriend(
                            freindsModel.id, modelIndex);
                      },
                      text: controller.initedList[modelIndex]
                          ? tr("Invited")
                          : tr("Invite"),
                      options: ButtonOptions(
                        width: 100,
                        height: 21,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: controller.initedList[modelIndex]
                            ? customColors.secondaryBackground
                            : customColors.primary,
                        textStyle: customTextStyle.titleSmall.override(
                          fontFamily: 'Nunito',
                          color: controller.initedList[modelIndex]
                              ? customColors.primary
                              : customColors.info,
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
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
