import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
class BuildPageIndecator extends StatelessWidget {
  const BuildPageIndecator({super.key,required this.pageController});
 final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Align(
                    alignment: const AlignmentDirectional(0.00, 1.00),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 150),
                      child: smooth_page_indicator.SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
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
                          dotColor:
                              customColors.secondaryBackground,
                          activeDotColor: customColors.primary,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),
                  );
                
  }
}