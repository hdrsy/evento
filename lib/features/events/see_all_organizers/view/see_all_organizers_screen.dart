import 'package:easy_localization/easy_localization.dart';
import 'package:evento/features/profile_pages/profile/controller/profile_controller.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/images/network_image.dart';
import '../../../../core/shared/widgets/text_fields/search_filed.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../home/model/home_oganizer.dart';
import '../controller/see_all_organizers_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllOrganizersScreen extends StatelessWidget {
  SeeAllOrganizersScreen({super.key});
  final SeeAllOrganizersController seeAllOrganizersController =
      Get.put(SeeAllOrganizersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        surfaceTintColor: customColors.secondaryBackground,
        backgroundColor: customColors.secondaryBackground,
        title: Text("Organizers",
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
        controller: seeAllOrganizersController.scrollController,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Obx(
          () => Column(
            children: [
              searchTextField(
                  controller: seeAllOrganizersController.searchController,
                  onChanged: (c) {}),
              ...List.generate(
                  seeAllOrganizersController.isSearchActive.value
                      ? seeAllOrganizersController.searchItemList.length
                      : seeAllOrganizersController.hasMoreData.value
                          ? seeAllOrganizersController.itemList.length + 1
                          : seeAllOrganizersController.itemList.length,
                  (index) => index < seeAllOrganizersController.itemList.length
                      ? OrganizerSeeAllCard(
                          modelId: index,
                          organizerHome: seeAllOrganizersController
                                  .isSearchActive.value
                              ? seeAllOrganizersController.searchItemList[index]
                              : seeAllOrganizersController.itemList[index],
                        )
                      : SizedBox())
            ].divide(SizedBox(
              height: 10,
            )),
          ),
        ),
      ),
    );
  }
}

class OrganizerSeeAllCard extends StatelessWidget {
  const OrganizerSeeAllCard(
      {super.key, required this.organizerHome, required this.modelId});
  final OrganizerHome organizerHome;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/OrganizerProfileScreen',
            arguments: [organizerHome.id, 0]);
      },
      child: SizedBox(
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
                        child: organizerHome.profile == ''
                            ? Image.asset(
                                'assets/images/faceBookProfile.jfif',
                                // fit: BoxFit.,
                                alignment: const Alignment(0, 0),
                                width: 90,
                                height: 90,
                              )
                            : getImageNetwork(
                                url: '/storage/${organizerHome.profile}',
                                width: 90,
                                height: 90)),
                    SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${organizerHome.name} ",
                        style: customTextStyle.bodyLarge.override(
                            fontSize: 16,
                            fontFamily: secondaryFontFamily,
                            useGoogleFonts: true),
                      ),
                    ),
                    Spacer(),
                    organizerHome.mobileUserId ==
                            Get.find<ProfileController>().profileModel.id
                        ? SizedBox()
                        : GetBuilder<SeeAllOrganizersController>(
                            builder: (controller) {
                            return ButtonWidget(
                              onPressed: () {
                                controller.followOrUnFollowOrganizer(
                                    organizerHome.id, modelId);
                              },
                              text: organizerHome.isFollowedByAuthUser
                                  ? tr("UnFollow")
                                  : tr("Follow"),
                              options: ButtonOptions(
                                width: 100,
                                height: 21,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                color: organizerHome.isFollowedByAuthUser
                                    ? customColors.secondaryBackground
                                    : customColors.primary,
                                textStyle: customTextStyle.titleSmall.override(
                                  fontFamily: 'Nunito',
                                  color: organizerHome.isFollowedByAuthUser
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
      ),
    );
  }
}
