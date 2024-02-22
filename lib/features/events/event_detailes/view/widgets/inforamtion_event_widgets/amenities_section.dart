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

Widget buildAmenitiesSection(BuildContext context) {
  final EventDetailesController eventDetailesController = Get.find();
  return eventDetailesController.eventDetailsModel.amenities.isEmpty
      ? const SizedBox.shrink()
      : Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amenities",
                    style: customTextStyle.bodySmall.override(
                        fontFamily: primaryFontFamily,
                        color: customColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts: true),
                  ).tr(),
                  GestureDetector(
                    onTap: () async {
                      // context.pushNamed('Amenities');
                      Get.toNamed('/SeeAllAmenities');
                    },
                    child: Text(
                      "See All",
                      style: customTextStyle.labelSmall.copyWith(
                        color: customColors.primary,
                        fontSize: 10,
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    eventDetailesController.eventDetailsModel.amenities.length >
                            5
                        ? 5
                        : eventDetailesController
                            .eventDetailsModel.amenities.length,
                    (index) => amentitesIcon(eventDetailesController
                        .eventDetailsModel.amenities[index].icon))
              ].divide(SizedBox(
                width: scaleWidth(5),
              )),
            )
          ],
        );
}

Container amentitesIcon(String imgUrl) {
  return Container(
    width: 50,
    height: 50,
    padding: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      border: Border.all(color: customColors.secondaryText, width: 2),
      color: customColors.primaryBackground,
      shape: BoxShape.circle,
      // image: DecorationImage(
      //     image: getImageNetwork(url: "$imgUrl", width: null, height: null)
      // .image)
    ),
    child: getImageNetworkforCahing(
        url: "$imgUrl",
        width: null,
        height: null,
        imgColor: customColors.secondaryText),
  );
}
