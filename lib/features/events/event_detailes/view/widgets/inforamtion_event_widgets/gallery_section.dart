import '../../../../../../core/responsive/responsive.dart';
import '../../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../../core/utils/helper/flutter_flow_util.dart';

import '../../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../controller/event_detailes_controller.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildGallerySection(BuildContext context) {
  final EventDetailesController eventDetailesController = Get.find();
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Gallery (Pre-Event)",
              style: customTextStyle.bodySmall.override(
                fontFamily: primaryFontFamily,
                color: customColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            GestureDetector(
              onTap: () {
                Get.toNamed('/GalleryScreen', arguments: {
                  "images": eventDetailesController.eventDetailsModel.images,
                  'videos': eventDetailesController.eventDetailsModel.videos
                });
              },
              child: Text(
                "See All",
                style: customTextStyle.labelSmall.override(
                  fontFamily: primaryFontFamily,
                  color: customColors.primary,
                  fontSize: 10,
                  useGoogleFonts: true,
                ),
              ).tr(),
            ),
          ],
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
              eventDetailesController.eventDetailsModel.images.length > 3
                  ? 3
                  : eventDetailesController.eventDetailsModel.images.length,
              (index) {
            return (index == 2 &&
                    eventDetailesController.eventDetailsModel.images.length > 3)
                ? Stack(
                    children: [
                      GalleryCard(
                        imgUrl:
                            "/storage/${eventDetailesController.eventDetailsModel.images[index]}",
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/GalleryScreen', arguments: {
                            "images":
                                eventDetailesController.eventDetailsModel.images
                          });
                        },
                        child: Container(
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0.00, 0.00),
                            child: Text(
                              "+ ${eventDetailesController.eventDetailsModel.images.length - 3}",
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: breeSerif,
                                color: customColors.info,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : GalleryCard(
                    imgUrl:
                        "/storage/${eventDetailesController.eventDetailsModel.images[index]}",
                  );
          })
        ].divide(SizedBox(
          width: scaleWidth(5),
        )),
      ),
    ],
  );
}

class GalleryCard extends StatelessWidget {
  const GalleryCard({super.key, required this.imgUrl});
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final EventDetailesController eventDetailesController = Get.find();
        Get.toNamed('/GalleryScreen', arguments: {
          "images": eventDetailesController.eventDetailsModel.images
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: getImageNetwork(
            url: imgUrl, width: screenWidth * 0.25, height: screenWidth * 0.25),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/pexels-clem-onojeghuo-111287.jpg',
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
    );
  }
}
