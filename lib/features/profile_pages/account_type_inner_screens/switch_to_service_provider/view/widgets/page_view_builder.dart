import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/utils/animation/animation_def.dart';
import '../../../../../../core/utils/animation/animation_util.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../controller/switch_to_service_provider_controller.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget pageViewBuilder(BuildContext context) {
  final SwithcToServiceProviderController swithcToServiceProviderController =
      Get.find();
  return PageView(
    controller: swithcToServiceProviderController.pageController,
    scrollDirection: Axis.horizontal,
    children: [
      pageInfo(context, 'assets/images/b20.png', 'service_provider_role',
          'service_provider_role_description'),
      pageInfo(
          context,
          'assets/images/gear_(2) (1).png',
          'service_provider_responsibilities',
          "service_provider_responsibilities_description"),
      pageInfo(context, 'assets/images/graph.png', 'service_provider_benefits',
          'service_provider_benefits_description'),
      pageInfo(
          context,
          'assets/images/start.png',
          'service_provider_getting_started',
          'service_provider_getting_started_description'),
      // Add more pages as needed
    ],
  );
}

Widget pageInfo(
    BuildContext context, String imageUrl, String titleKey, String contentKey) {
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
    // clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(shape: BoxShape.circle),
    child: imageUrl.startsWith('https')
        ? Image.network(imageUrl, fit: BoxFit.cover)
        : Image.asset(imageUrl, fit: BoxFit.contain),
  );
}

Widget customTextWidget(BuildContext context, String textKey, bool isTitle) {
  return Align(
    alignment: const AlignmentDirectional(0, 0),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, isTitle ? 10 : 40),
      child: Text(
        tr(textKey),
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
  final SwithcToServiceProviderController swithcToServiceProviderController =
      Get.find();

  return Align(
    alignment: const AlignmentDirectional(0, 1),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 80),
      child: SmoothPageIndicator(
        controller: swithcToServiceProviderController.pageController,
        count: 4,
        axisDirection: Axis.horizontal,
        onDotClicked: (i) async {
          await swithcToServiceProviderController.pageController.animateToPage(
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
