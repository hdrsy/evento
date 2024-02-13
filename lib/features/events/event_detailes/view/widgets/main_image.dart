import 'package:evento/features/gallery/controller/gallery_controller.dart';
import 'package:evento/features/gallery/view/show_on_fullscreen.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;

class MainImage extends StatelessWidget {
  MainImage({super.key, required this.imgUrl});
  final List<String> imgUrl;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.35,
          child: Align(
              alignment: const AlignmentDirectional(0.00, 0.00),
              child: PageView.builder(
                controller: pageController,
                itemCount: imgUrl.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    Get.to(ShowInFullScreen(
                        imageUrl:
                            GalleryItem(url: imgUrl[index], isVideo: false),
                        tag: imgUrl[index]));
                  },
                  child: Hero(
                    tag: imgUrl[index],
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: getImageNetworkforCahing(
                            url: imgUrl[index],
                            width: double.infinity,
                            height: double.infinity)),
                  ),
                ),
              )

              // ),
              ),
        ),
        Positioned(
            right: 20,
            top: screenHeight * 0.3,
            child: BuildPageIndecator(
              itemCount: imgUrl.length,
              pageController: pageController,
            )),
        Align(
          alignment: const AlignmentDirectional(-0.9, -0.9),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: const Color(0x3A000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconWithContainer(
              backgroundColor: Colors.transparent,
              buttonSize: 46,
              borderRadius: 10,
              icon: Icons.arrow_back_rounded,
              iconColor: customColors.info,
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BuildPageIndecator extends StatelessWidget {
  const BuildPageIndecator(
      {super.key, required this.pageController, required this.itemCount});
  final PageController pageController;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.00, 0.60),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: smooth_page_indicator.SmoothPageIndicator(
          controller: pageController,
          count: itemCount,
          axisDirection: Axis.horizontal,
          onDotClicked: (i) async {
            await pageController.animateToPage(
              i,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          effect: smooth_page_indicator.ExpandingDotsEffect(
            expansionFactor: 3,
            spacing: 8,
            radius: 16,
            dotWidth: 10,
            dotHeight: 8,
            dotColor: customColors.secondaryBackground,
            activeDotColor: customColors.primary,
            paintStyle: PaintingStyle.fill,
          ),
        ),
      ),
    );
  }
}
