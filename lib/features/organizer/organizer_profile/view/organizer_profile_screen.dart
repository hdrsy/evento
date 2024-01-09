import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/animation/animation_text.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/organizer/organizer_profile/controller/organizer_profile_controller.dart';
import 'package:evento/features/organizer/organizer_profile/view/widgets/folder_card.dart';
import 'package:evento/features/organizer/organizer_profile/view/widgets/organizer_followers_card.dart';
import 'package:evento/features/organizer/organizer_profile/view/widgets/organzer_event_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizerProfileScreen extends StatelessWidget {
  OrganizerProfileScreen({super.key});
  final OrganizerProfileController organizerProfileController = Get.find();
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
    return Align(
      alignment: const AlignmentDirectional(0, -1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Image.network(
          'https://picsum.photos/seed/902/600',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
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
                image: Image.network(
              'https://picsum.photos/seed/902/600',
              fit: BoxFit.cover,
            ).image)),
      ),
    );
  }
}

class NameAndFollow extends StatelessWidget {
  NameAndFollow({super.key});
  final OrganizerProfileController organizerProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          marqueeTitle(
            """ organizerProfileController
                .organizerProfileModel.organizerInfo.namedddddddddddddddddddddddddddddddd""",
            heigthFromTheScreen: 0.04,
            widthFromTheScreen: 0.4,
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 24,
          ),
          GetBuilder<OrganizerProfileController>(builder: (context) {
            return ButtonWidget(
              onPressed: () async {
                organizerProfileController.followOrUnFollowOrganizer(
                    organizerProfileController.orgnizerId);
              },
              text: organizerProfileController
                      .organizerProfileModel.organizerInfo.isFollowedByAuthUser
                  ? "Following"
                  : "Follow",
              icon: const Icon(
                Icons.person_add_outlined,
                size: 20,
              ),
              options: ButtonOptions(
                width: 150,
                height: 35,
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 23, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: organizerProfileController.organizerProfileModel
                        .organizerInfo.isFollowedByAuthUser
                    ? customColors.secondaryBackground
                    : customColors.primary,
                textStyle: customTextStyle.titleSmall.override(
                  fontFamily: secondaryFontFamily,
                  color: organizerProfileController.organizerProfileModel
                          .organizerInfo.isFollowedByAuthUser
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
      ),
    );
  }
}

class StaticSection extends StatelessWidget {
  StaticSection({super.key});
  final OrganizerProfileController organizerProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        statisticSingleElement(
            count: organizerProfileController
                .organizerProfileModel.organizedEvents.length
                .toString(),
            title: "Events"),
        const statisticSingleElement(title: "Followers", count: "65 K"),
        const statisticSingleElement(title: "Following", count: "20"),
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
        length: 4,
        child: Column(
          children: [
            _buildTabBar(context),
            Expanded(
              child: TabBarView(
                children: [
                  _buildBioTab(context),
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
        unselectedLabelStyle: const TextStyle(),
        indicatorColor: customColors.primary,
        padding: const EdgeInsets.all(4),
        tabs: const [
          Tab(text: 'Bio'),
          Tab(text: 'Events'),
          Tab(text: 'Followers'),
          Tab(text: 'Gallery'),
        ],
      ),
    );
  }

  Widget _buildBioTab(BuildContext context) {
    final OrganizerProfileController organizerProfileController = Get.find();

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
    final OrganizerProfileController organizerProfileController = Get.find();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ...List.generate(
              organizerProfileController
                  .organizerProfileModel.organizedEvents.length,
              (index) => OrganizerEventCard(
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
          ...List.generate(3, (index) => const OrganizerFolloersCard())
        ].divide(const SizedBox(
          height: 10,
        )),
      ),
    );
  }

  Widget _buildGalleryTab(BuildContext context) {
    final OrganizerProfileController organizerProfileController = Get.find();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          ...List.generate(
              organizerProfileController
                  .organizerProfileModel.organizerInfo.albums.length,
              (index) => OrganizerFolderCard(
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
