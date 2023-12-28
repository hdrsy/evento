import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/organizer/organizer_profile/view/widgets/folder_card.dart';
import 'package:evento/features/organizer/organizer_profile/view/widgets/organizer_followers_card.dart';
import 'package:evento/features/organizer/organizer_profile/view/widgets/organzer_event_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizerProfileScreen extends StatelessWidget {
  const OrganizerProfileScreen({super.key});

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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildTopSection(context),
          const NameAndFollow(),
   
          Divider(
            height: 30,
            thickness: 1,
            color: customColors.secondary,
          ),
          const StaticSection(),
          Divider(
            height: 30,
            thickness: 1,
            color: customColors.secondary,
          ),
const MyTabBarWidget()

        ],
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
  const NameAndFollow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: const AlignmentDirectional(0, -1),
          child: Text(
            "Spark",
            style: customTextStyle.headlineMedium.override(
              fontFamily: 'Plus Jakarta Sans',
              color: customColors.primaryText,
              fontSize: 24,
              useGoogleFonts: true,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ButtonWidget(
          onPressed: () async {},
          text: "Following",
          icon: const Icon(
            Icons.person_add_outlined,
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
        ),
      ].divide(const SizedBox(width: 90)),
    );
  }
}

class StaticSection extends StatelessWidget {
  const StaticSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const statisticSingleElement(count: "10", title: "Events"),
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
        tabs:const [
           Tab(text: 'Bio'),
           Tab(text: 'Events'),
           Tab(text: 'Followers'),
           Tab(text: 'Gallery'),
        ],
      ),
    );
  }

  Widget _buildBioTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
    
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            """Event organizer specialize in turning your dreams into reality with stunning decorations, ambient lighting, and exquisite floral arrangements. Whether it's an intimate wedding, a milestone birthday, or a grand anniversary celebration, we are dedicated to creating unforgettable experiences that reflect your unique style and personal touch. With a keen eye for detail and a passion for perfection, our team ensures that each event is a masterpiece of beauty and elegance. Trust Spark to light up your special occasions with sophistication and joy.""",
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildEventsTab(BuildContext context) {
    return SingleChildScrollView(
       padding: const EdgeInsets.symmetric(horizontal: 24),
    
      child: Column(children: [
        ...List.generate(3, (index) =>const OrganizerEventCard())
      ].divide(const SizedBox(height: 10,)),),
    );
  }

  Widget _buildFollowersTab(BuildContext context) {
    return SingleChildScrollView(
       padding: const EdgeInsets.symmetric(horizontal: 24),
    
      child: Column(children: [
        ...List.generate(3, (index) =>const OrganizerFolloersCard())
      ].divide(const SizedBox(height: 10,)),),
    );
  
  }

  Widget _buildGalleryTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(children: [
        ...List.generate(3, (index) =>const OrganizerFolderCard())
      ].divide(const SizedBox(height: 10,)),),
    );
    // Your code for the Gallery tab
  }

}
