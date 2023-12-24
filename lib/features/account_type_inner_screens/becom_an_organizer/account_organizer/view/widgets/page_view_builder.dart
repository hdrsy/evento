import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/account_type_inner_screens/becom_an_organizer/account_organizer/controller/account_organizer_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget accountOrganizerPageViewBuilder(BuildContext context) {
 final AccountOrganizerController accountOrganizerController=Get.find();
    return PageView(
      controller: accountOrganizerController.pageController,
      scrollDirection: Axis.horizontal,
      children: [
        pageInfo(context, 'https://picsum.photos/seed/345/600', 'Essential Qualities of an Organizer', 'Organizers are visionaries who do more than just arrange events; they conceive and execute unforgettable experiences.'),
        pageInfo(context, 'https://picsum.photos/seed/345/600', 'Duties and Prospects', 'Organizers are responsible for orchestrating events that are both impactful and inspirational.'),
        pageInfo(context, 'https://picsum.photos/seed/345/600', 'Exclusive Advantages for Organizers', 'The platform empowers Organizers with the capability to craft unlimited events, providing the liberty to be innovative without limitations.'),
        pageInfo(context, 'https://picsum.photos/seed/345/600', 'Get new contact options', 'Add a contact button to your profile to make it easier for people to get in touch with you.'),
        // Add more pages as needed
      ],
    );
  }
   Widget pageInfo(BuildContext context, String imageUrl, String titleKey, String contentKey) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customImageWidget(imageUrl),
        customTextWidget(context, titleKey, true),
        customTextWidget(context, contentKey, false),
      ],
    );
  }
 Widget customImageWidget(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: imageUrl.startsWith('https') 
          ? Image.network(imageUrl, fit: BoxFit.cover) 
          : Image.asset(imageUrl, fit: BoxFit.cover),
    );
  }
  Widget customTextWidget(BuildContext context, String textKey, bool isTitle) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, isTitle ? 10 : 40),
        child: Text(
          textKey,
          textAlign: TextAlign.center,
          style: isTitle
              ? customTextStyle.headlineSmall.override(
                    fontFamily: 'Nunito',
                    color: customColors.primaryText,
                    useGoogleFonts: true,
                )
              : customTextStyle.bodySmall.override(
                    fontFamily: 'Nunito',
                    color: customColors.primaryText,
                    useGoogleFonts: true,
                ),
        ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
      ),
    );
  }
  
  Widget bottomIndicator(BuildContext context) {
    final AccountOrganizerController accountOrganizerController=Get.find();
 
    return Align(
      alignment: const AlignmentDirectional(0, 1),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 80),
        child: SmoothPageIndicator(
          controller:  accountOrganizerController.pageController,
          count: 4,
          axisDirection: Axis.horizontal,
          onDotClicked: (i) async {
            await accountOrganizerController.pageController .animateToPage(
              i,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          effect: SlideEffect(
            spacing: 8,
            radius: 16,
            dotWidth: 5,
            dotHeight: 8,
            dotColor: customColors.primaryBackground,
            activeDotColor: customColors.primary,
            paintStyle: PaintingStyle.fill,
          ),
        ),
      ),
    );
  }
