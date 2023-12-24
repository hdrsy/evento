import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/account_type_inner_screens/switch_to_service_provider/controller/switch_to_service_provider_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget pageViewBuilder(BuildContext context) {
 final SwithcToServiceProviderController swithcToServiceProviderController=Get.find();
    return PageView(
      controller: swithcToServiceProviderController.pageController,
      scrollDirection: Axis.horizontal,
      children: [
        pageInfo(context, 'https://picsum.photos/seed/345/600', 'Get professional tools', 'With a service provider account, you get access to tools like insights about your followers and account performance , new contact options and more.'),
        pageInfo(context, 'https://picsum.photos/seed/345/600', 'Learn about your followers', 'Get insights about your followers and see how your posts are performing.'),
        pageInfo(context, 'https://picsum.photos/seed/345/600', 'Reach more people', 'Create ads on Evento to help reach more people and build your community.'),
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
    final SwithcToServiceProviderController swithcToServiceProviderController=Get.find();
 
    return Align(
      alignment: const AlignmentDirectional(0, 1),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 80),
        child: SmoothPageIndicator(
          controller:  swithcToServiceProviderController.pageController,
          count: 4,
          axisDirection: Axis.horizontal,
          onDotClicked: (i) async {
            await swithcToServiceProviderController.pageController .animateToPage(
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
