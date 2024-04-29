import 'package:evento/core/const/share_event_and_app.dart';
import 'package:evento/core/shared/widgets/guest/guest_popup.dart';
import 'package:evento/core/utils/helper/number_formatter.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/server/server_config.dart';
import '../../../../../core/shared/widgets/buttons/toggle_icon.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/shared/widgets/video/cards_video_widget.dart';
import '../../../../../core/utils/animation/animation_def.dart';
import '../../../../../core/utils/animation/animation_util.dart';
import '../../../../../core/utils/animation/shimmer_animation.dart';
import '../../../../../core/utils/helper/date_formatter.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/home_controller.dart';
import '../../model/event_model.dart';
import 'column_text.dart';
import 'home_loading_widget.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class FeaturedList extends StatelessWidget {
  FeaturedList({super.key});
  final FeaturedListController featuredListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => featuredListController.isLoading.value
          ? ShimmerLoadingWidget(
              loadingShimmerWidget: featuredLoading(),
            )
          : featuredListController.itemList.isEmpty
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColumnText(
                      title: tr("Featured"),
                      subTitle: tr("Enchanted Evening & Festive Lights"),
                      onTap: () {
                        Get.toNamed('/seeAll', arguments: [
                          featuredListController.pageId,
                          featuredListController.itemList,
                          isGuset
                              ? ServerConstApis.getFeaturedListforGuest
                              : ServerConstApis.getFeaturedList,
                          "featured_event",
                          "Featured"
                        ]);
                      },
                    ),
                    SizedBox(
                      height: scaleHeight(8),
                    ),
                    SizedBox(
                      // height: scaleHeight(330),
                      child: SingleChildScrollView(
                          controller: featuredListController.scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                  featuredListController.hasMoreData.value
                                      ? featuredListController.itemList.length +
                                          1
                                      : featuredListController.itemList.length,
                                  (index) {
                                return index <
                                        featuredListController.itemList.length
                                    ? FeaturedWidget(
                                        eventModel: featuredListController
                                            .itemList[index],
                                        modelIndex: index,
                                      )
                                    : ShimmerLoadingWidget(
                                        loadingShimmerWidget: Container(
                                        width: 355,
                                        height: 300,
                                        // height: 330 ,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: customColors.info,
                                            ),
                                            color: customColors.info),
                                      ));
                              })
                            ].divide(const SizedBox(
                              width: 10,
                            )),
                          )),
                    )
                  ],
                ),
    );
  }
}

class FeaturedWidget extends StatelessWidget {
  const FeaturedWidget(
      {super.key, required this.eventModel, required this.modelIndex});
  final EventModel eventModel;
  final int modelIndex;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedListController>(builder: (context) {
      return GestureDetector(
        onTap: () {
          Get.toNamed('/eventDetailes', parameters: {
            'id': eventModel.id.toString(),
            'isOffer': false.toString(),
            'offerPercent': 0.toString(),
          });
        },
        child: Container(
          width: screenWidth * 0.9, // height: 330 ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: customColors.primaryBackground,
            ),
          ),
          child: Align(
            alignment: const AlignmentDirectional(0.00, -1.00),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  mediaStack(eventModel),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(18, 8, 18, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            eventModel.title.length > 20
                                ? SizedBox(
                                    width: screenWidth * 0.5,
                                    height: screenHeight * 0.03,
                                    child: Marquee(
                                      text: eventModel.title,
                                      scrollAxis: Axis.horizontal,
                                      blankSpace: 20.0,
                                      velocity: 70.0,
                                      pauseAfterRound:
                                          const Duration(seconds: 3),
                                      style: customTextStyle.headlineSmall
                                          .override(
                                        fontFamily: 'BeerSerif',
                                        color: customColors.primaryText,
                                        fontSize: 18,
                                        useGoogleFonts: false,
                                      ),
                                    ),
                                  )
                                : Text(
                                    eventModel.title,
                                    style:
                                        customTextStyle.headlineSmall.override(
                                      fontFamily: 'BeerSerif',
                                      color: customColors.primaryText,
                                      fontSize: 18,
                                      useGoogleFonts: false,
                                    ),
                                  ),
                            Text(
                              DateFormatter.formatDate(eventModel.startDate),
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: 'BeerSerif',
                                color: customColors.primary,
                                useGoogleFonts: false,
                              ),
                            ),
                            Text(
                              DateFormatter.formatTime(eventModel.startDate),
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: 'BeerSerif',
                                color: customColors.secondaryText,
                                fontSize: 12,
                                useGoogleFonts: false,
                              ),
                            ),
                          ].divide(const SizedBox(height: 3)),
                        ),
                        priceIcons(
                            eventModel.ticketPrice,
                            eventModel.isFollowedByAuthUser,
                            modelIndex,
                            eventModel.id),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget mediaStack(EventModel eventModel) {
    final FeaturedListController featuredListController = Get.find();

    return GestureDetector(
      onTap: () {
        Get.toNamed('/eventDetailes', parameters: {
          'id': eventModel.id.toString(),
          'isOffer': false.toString(),
          'offerPercent': 0.toString(),
        });
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: eventModel.videos.isEmpty
                ? getImageNetworkforCahing(
                    url: "/storage/${eventModel.images[0]}",
                    width: double.infinity,
                    height: 190)
                : SizedBox(
                    height: 190,
                    child: CardsVideoWidget(
                      soundControlCallback: () =>
                          featuredListController.sound(),
                      currentVideoUrl:
                          "${ServerConstApis.baseAPIImage}/storage/${eventModel.videos[0]}",
                      videoHgiht: 190,
                      videoWidth: double.infinity,
                    ),
                  ),
          ),
          eventModel.videos.isNotEmpty
              ? Positioned(
                  bottom: scaleWidth(0),
                  right: scaleWidth(0),
                  //  alignment: AlignmentDirectional(0.00, 0.00),

                  child: soundToggleIcon())
              : const SizedBox.shrink(),
          // eventModel.offer == null
          //     ? SizedBox()
          //     : Padding(
          //         padding: const EdgeInsets.all(16),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.max,
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               width: 60,
          //               height: 30,
          //               decoration: BoxDecoration(
          //                 color: customColors.primary,
          //                 borderRadius: BorderRadius.circular(16),
          //               ),
          //               child: Align(
          //                 alignment: const AlignmentDirectional(0, 0),
          //                 child: Text(
          //                   "Offer",
          //                   textAlign: TextAlign.center,
          //                   style: customTextStyle.bodyMedium.override(
          //                     fontFamily: 'Nunito',
          //                     color: customColors.info,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.bold,
          //                     useGoogleFonts: false,
          //                   ),
          //                 ).tr(),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
        ],
      ),
    );
  }

  Widget soundToggleIcon() {
    final FeaturedListController featuredListController = Get.find();

    return Obx(
      () => ToggleIconWithouIconButton(
        onPressed: () => featuredListController.sound(),
        value: featuredListController.isSoundEnabled.value,
        onIcon: Icon(
          Icons.volume_off,
          color: customColors.info,
          size: 25,
        ),
        offIcon: Icon(
          Icons.volume_up_outlined,
          color: customColors.info,
          size: 25,
        ),
      ),
    );
  }

  Widget priceIcons(
      ticketPrice, bool isFollowedByAuthUser, int modelIndex, int eventId) {
    final EventStateManager eventStateManager = Get.find();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    // const String message = "Check out this event in Evento";
                    // final String url =
                    //     "http://94.141.219.13:8003/#/eventDetailes/$eventId"; // Replace with your event link
                    // final String shareContent =
                    //     "$message\n\nFor more details, visit: $url";

                    // await Share.share(shareContent);
                    await shareApp(eventId);
                  },
                  child: Icon(
                    Icons.share_rounded,
                    color: customColors.primaryText,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Obx(() {
                  var eventModel =
                      eventStateManager.getEventById(eventId).value;

                  return ToggleIconWithouIconButton(
                    onPressed: () async {
                      if (isGuset) {
                        Get.dialog(const GuestPopupWidget());
                      } else {
                        final FeaturedListController featuredListController =
                            Get.find();
                        featuredListController.followOrUnFollowEvent(
                            eventModel.id, modelIndex);
                      }
                    },
                    value: eventModel.isFollowedByAuthUser,
                    onIcon: Icon(
                      Icons.favorite_sharp,
                      color: customColors.error,
                      size: 25,
                    ),
                    offIcon: Icon(
                      Icons.favorite_border,
                      color: customColors.secondaryText,
                      size: 25,
                    ),
                  ).animateOnPageLoad(
                      animationsMap['toggleIconOnPageLoadAnimation1']!);
                })
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 100,
            // height: 20,
            decoration: BoxDecoration(
              color: customColors.primaryBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
              alignment: const AlignmentDirectional(0.00, 0.00),
              child: Text(
                "${formatPrice(ticketPrice)} ${tr("sp")}",
                textAlign: TextAlign.center,
                style: customTextStyle.bodyMedium.override(
                  fontFamily: 'BeerSerif',
                  color: customColors.primaryText,
                  useGoogleFonts: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
