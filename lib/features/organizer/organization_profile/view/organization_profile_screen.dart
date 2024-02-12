import 'package:evento/core/shared/widgets/images/network_image.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/utils/animation/animation_text.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../controller/organization_profile_controller.dart';
import 'widgets/folder_card.dart';
import 'widgets/organizer_followers_card.dart';
import 'widgets/organzer_event_card.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class OrganizationProfileScreen extends StatelessWidget {
  OrganizationProfileScreen({super.key});
  final OrganizationProfileController organizerProfileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
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
        () => organizerProfileController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: customColors.primary,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildTopSection(context),
                  NameAndFollow(),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: customColors.secondary,
                  ),
                  StaticSection(),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: customColors.secondary,
                  ),
                  const MyTabBarWidget()
                ],
              ),
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
      child: SizedBox(
        height: screenHeight * 0.25,
        child: Stack(
          children: [
            _buildBackgroundImage(),
            _buildProfileImage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    final OrganizationProfileController organizerProfileController = Get.find();
    return Align(
      alignment: const AlignmentDirectional(0, -1),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: getImageNetwork(
              url:
                  "/storage/${organizerProfileController.organizerProfileModel.organizerInfo.cover}",
              width: double.infinity,
              height: null)),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(-0.87, 1.69),
      child: Container(
        width: screenWidth * 0.3,
        height: screenWidth * 0.3,
        decoration: BoxDecoration(
            color: customColors.primaryBackground,
            shape: BoxShape.circle,
            border: Border.all(
              color: customColors.secondaryBackground,
              width: 2,
            ),
            image: DecorationImage(
                image: getImageNetwork(
                        url:
                            "/storage/${organizerProfileController.organizerProfileModel.organizerInfo.profile}",
                        width: double.infinity,
                        height: null)
                    .image)),
      ),
    );
  }
}

class NameAndFollow extends StatelessWidget {
  NameAndFollow({super.key});
  final OrganizationProfileController organizerProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          marqueeTitle(
            organizerProfileController.organizerProfileModel.organizerInfo.name,
            heigthFromTheScreen: 0.04,
            widthFromTheScreen: 0.4,
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 24,
          ),
          GetBuilder<OrganizationProfileController>(builder: (context) {
            return

                // !organizerProfileController.isorganizerEditProfile?
                ButtonWidget(
              onPressed: () async {
                // organizerProfileController.followOrUnFollowOrganizer(
                //     organizerProfileController.orgnizerId);
              },
              text: "Edit profile",
              icon: const Icon(
                Icons.edit,
                size: 20,
              ),
              options: ButtonOptions(
                width: 150,
                height: 35,
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 23, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: customColors.primary,
                textStyle: customTextStyle.titleSmall.override(
                  fontFamily: secondaryFontFamily,
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
          }),
        ],
      ),
    );
  }
}

class StaticSection extends StatelessWidget {
  StaticSection({super.key});
  final OrganizationProfileController organizerProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        statisticSingleElement(
            count: organizerProfileController
                .organizerProfileModel.organizedEventsCount
                .toString(),
            title: tr("Events")),
        statisticSingleElement(
            title: tr("Followers"),
            count: organizerProfileController
                        .organizerProfileModel.followersCount >
                    1000
                ? """${organizerProfileController.organizerProfileModel.followersCount / 1000} K"""
                : organizerProfileController
                    .organizerProfileModel.organizedEventsCount
                    .toString()),
        // statisticSingleElement(
        //     title: tr("Following"),
        //     count: organizerProfileController
        //         .organizerProfileModel.followingCount
        //         .toString()),
      ].divide(
        SizedBox(
          height: 60,
          child: VerticalDivider(
            thickness: 1,
            color: customColors.secondary,
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class statisticSingleElement extends StatelessWidget {
  const statisticSingleElement({
    super.key,
    required this.title,
    required this.count,
  });
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          count,
          textAlign: TextAlign.center,
          style: customTextStyle.displaySmall.override(
            fontFamily: 'Plus Jakarta Sans',
            color: customColors.primaryText,
            fontSize: 36,
            useGoogleFonts: true,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: customTextStyle.displaySmall.override(
            fontFamily: 'Plus Jakarta Sans',
            color: customColors.primaryText,
            fontSize: 16,
            useGoogleFonts: true,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class MyTabBarWidget extends StatelessWidget {
  const MyTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            _buildTabBar(context),
            Expanded(
              child: TabBarView(
                children: [
                  _buildEventsTab(context),
                  _buildFollowersTab(context),
                  _buildGalleryTab(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0),
      child: TabBar(
        labelColor: customColors.primaryText,
        unselectedLabelColor: customColors.secondaryText,
        labelStyle: customTextStyle.bodyMedium.override(
          fontFamily: 'Nunito',
          fontSize: 12,
          useGoogleFonts: true,
        ),
        indicatorColor: customColors.primary,
        indicatorWeight: 4,
        dividerColor: customColors.secondaryBackground,

        unselectedLabelStyle: const TextStyle(),
        // indicatorColor: customColors.primary,
        padding: const EdgeInsets.all(4),
        tabs: [
          Tab(text: tr('Events')),
          Tab(text: tr('Followers')),
          Tab(text: tr('Gallery')),
        ],
      ),
    );
  }

  Widget _buildBioTab(BuildContext context) {
    final OrganizationProfileController organizerProfileController = Get.find();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            organizerProfileController.organizerProfileModel.organizerInfo.bio,
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildEventsTab(BuildContext context) {
    final OrganizationProfileController organizerProfileController = Get.find();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ...List.generate(
              organizerProfileController
                  .organizerProfileModel.organizedEvents.length,
              (index) => OrganizationEventCard(
                    modelIndex: index,
                    organizerProfileEvent: organizerProfileController
                        .organizerProfileModel.organizedEvents[index],
                  ))
        ].divide(const SizedBox(
          height: 10,
        )),
      ),
    );
  }

  Widget _buildFollowersTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ...List.generate(3, (index) => const OrganizationFolloersCard())
        ].divide(const SizedBox(
          height: 10,
        )),
      ),
    );
  }

  Widget _buildGalleryTab(BuildContext context) {
    final OrganizationProfileController organizerProfileController = Get.find();
    print(
        organizerProfileController.organizerProfileModel.organizerInfo.albums);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          ...List.generate(
              organizerProfileController
                  .organizerProfileModel.organizerInfo.albums.length,
              (index) => OrganizationFolderCard(
                    album: organizerProfileController
                        .organizerProfileModel.organizerInfo.albums[index],
                  ))
        ].divide(const SizedBox(
          height: 10,
        )),
      ),
    );
    // Your code for the Gallery tab
  }
}
