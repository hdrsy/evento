import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/helper/number_formatter.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/responsive/responsive.dart';
import '../../../../../../core/shared/functions/lists/carouse_options_functions.dart';
import '../../../../../../core/shared/widgets/buttons/toggle_icon.dart';
import '../../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../../core/shared/widgets/lists/carousel_slider.dart';
import '../../../../../../core/utils/animation/animation_text.dart';
import '../../../../../../core/utils/helper/date_formatter.dart';
import '../../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../controller/event_detailes_controller.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildMoreEventsSection(BuildContext context) {
  final EventDetailesController eventDetailesController = Get.find();

  return eventDetailesController.relatedEvents.isEmpty
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
                    "More Events like this",
                    style: customTextStyle.bodySmall.override(
                      fontFamily: 'Open Sans',
                      color: customColors.primaryText,
                      fontSize: 16,
                      useGoogleFonts: true,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/seeAll', arguments: [
                        1,
                        eventDetailesController.relatedEvents,
                        ServerConstApis.getFeaturedList,
                        "relatedEvents",
                        "More Evenet Like This "
                      ]);
                    },
                    child: Text(
                      "See All",
                      style: customTextStyle.labelSmall.override(
                        fontFamily: breeSerif,
                        color: customColors.primary,
                        fontSize: 10,
                        useGoogleFonts: true,
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ),
            // Carousel or List of Additional Events
            // Placeholder for carousel/slider/list widget
            eventDetailesController.relatedEvents.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: buildListShow(
                        body: List.generate(
                          eventDetailesController.relatedEvents.length,
                          (index) => MoreEventsCard(
                            relatedEventModel:
                                eventDetailesController.relatedEvents[index],
                            modelId: index,
                          ),
                        ),
                        carouselOptions:
                            eventDetailesController.relatedEvents.length == 1
                                ? CaroucelOptionFunctions.seeMoreEventsJustOne
                                : CaroucelOptionFunctions.seeMoreEvents),
                  ),
          ],
        );
}

class MoreEventsCard extends StatelessWidget {
  const MoreEventsCard(
      {super.key, required this.relatedEventModel, required this.modelId});
  final EventModel relatedEventModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: GestureDetector(
        onTap: () {
          final EventDetailesController eventDetailesController = Get.find();
          eventDetailesController.eventId = relatedEventModel.id;
          eventDetailesController.getEventDetailesModel();
        },
        child: Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.2,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: customColors.tertiary,
            ),
          ),
          child: Align(
            alignment: const AlignmentDirectional(0.00, -1.00),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: getImageNetworkforCahing(
                              url: "/storage/${relatedEventModel.images[0]}",
                              width: double.infinity,
                              height: screenHeight * 0.15,
                              alignmentGeometry: const Alignment(0.00, 1.00))),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GetBuilder<EventDetailesController>(
                            builder: (controller) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 5, 0),
                            child: ToggleIcon(
                              onPressed: () async {
                                controller.followOrUnFollowEvent(
                                    relatedEventModel.id, modelId);
                              },
                              value: relatedEventModel.isFollowedByAuthUser,
                              onIcon: Icon(
                                Icons.favorite_rounded,
                                color: customColors.rejected,
                                size: 25,
                              ),
                              offIcon: Icon(
                                Icons.favorite_border,
                                color: customColors.info,
                                size: 25,
                              ),
                            ),
                          );
                        }),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 5,
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 24,
                          decoration: BoxDecoration(
                            color: customColors.primaryBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${formatPrice(relatedEventModel.ticketPrice)} ${tr("sp")}",
                            textAlign: TextAlign.center,
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: breeSerif,
                              color: customColors.primaryText,
                              useGoogleFonts: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.h,
                          child: marqueeTitle(relatedEventModel.title),
                        ),
                        // Icon(
                        //   Icons.play_arrow_outlined,
                        //   color: customColors.primaryText,
                        //   size: 25,
                        // ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              DateFormatter.formatDate(
                                  relatedEventModel.startDate),
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: breeSerif,
                                color: customColors.primary,
                                fontSize: 12,
                                useGoogleFonts: false,
                              ),
                            ),
                            Text(
                              DateFormatter.formatTime(
                                  relatedEventModel.startDate),
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: breeSerif,
                                color: customColors.primary,
                                fontSize: 12,
                                useGoogleFonts: false,
                              ),
                            ),
                          ].divide(const SizedBox(width: 5)),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: customColors.secondaryText,
                          size: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
