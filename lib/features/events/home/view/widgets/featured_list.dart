import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/shared/widgets/video/cards_video_widget.dart';
import 'package:evento/core/shared/widgets/video/reels_video_widget.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:evento/features/events/home/view/widgets/column_text.dart';
import 'package:evento/features/events/home/view/widgets/home_loading_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

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
          : featuredListController.itemList.isEmpty?const SizedBox():
          
          
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColumnText(
                  title: "Featured",
                  subTitle: " Enchanted Evening & Festive Lights",
                  onTap: () {
                    Get.toNamed('/seeAll', arguments: [
                      featuredListController.pageId,
                      featuredListController.itemList,
                      ServerConstApis.getFeaturedList,
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
                                  ? featuredListController.itemList.length + 1
                                  : featuredListController.itemList.length,
                              (index) {
                            return index <
                                    featuredListController.itemList.length
                                ? FeaturedWidget(
                                    eventModel:
                                        featuredListController.itemList[index],
                                    modelIndex: index,
                                  )
                                : ShimmerLoadingWidget(
                                    loadingShimmerWidget: Container(
                                    width: 355,
                                    height: 300,
                                    // height: 330 ,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: customColors.info,
                                        ),
                                        color: customColors.info),
                                  ));
                          })
                        ].divide(SizedBox(
                          width: scaleWidth(
                            screenSize == ScreenSize.small
                                ? 8
                                : (screenSize == ScreenSize.medium ? 10 : 12),
                          ),
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
      return Container(
        width: screenSize == ScreenSize.small
            ? 320
            : (screenSize == ScreenSize.medium ? 355 : 370),
        // height: 330 ,
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
                InkWell(
                  onTap: () {
                    Get.toNamed('/eventDetailes', arguments: eventModel.id);
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(18, 8, 18, 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventModel.title,
                          style: customTextStyle.headlineSmall.override(
                            fontFamily: 'BeerSerif',
                            color: customColors.primaryText,
                            fontSize: screenSize == ScreenSize.small
                                ? 16
                                : (screenSize == ScreenSize.medium ? 18 : 20),
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
                        priceIcons(eventModel.ticketPrice,
                            eventModel.isFollowedByAuthUser, modelIndex),
                      ].divide(const SizedBox(height: 3)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Stack mediaStack(EventModel eventModel) {
    return Stack(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            // context.pushNamed('Event-Details');
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: eventModel.videos.isEmpty
                ? getImageNetwork(
                    url: "/storage/${eventModel.images[0]}",
                    width: double.infinity,
                    height: 190)
                : CardsVideoWidget(
                    currentVideoUrl:
                        "${ServerConstApis.baseAPI}/storage/${eventModel.videos[0]}",
                    videoHgiht: 190,
                    videoWidth: double.infinity,
                  ),
          ),
        ),
        Positioned(
            bottom: scaleWidth(0),
            right: scaleWidth(0),
            //  alignment: AlignmentDirectional(0.00, 0.00),

            child: soundToggleIcon())
      ],
    );
  }

  Widget soundToggleIcon() {
    return ToggleIcon(
      onPressed: () async {},
      value: false,
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
    );
  }

  Row priceIcons(ticketPrice, bool isFollowedByAuthUser, int modelIndex) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
              "$ticketPrice s.p",
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.override(
                fontFamily: 'BeerSerif',
                color: customColors.primaryText,
                useGoogleFonts: false,
              ),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await Share.share(
                    'Check out this event in Evento',
                  );
                },
                child: Icon(
                  Icons.share_rounded,
                  color: customColors.primaryText,
                  size: 20,
                ),
              ),
              ToggleIcon(
                onPressed: () async {
                  final FeaturedListController featuredListController =
                      Get.find();
                  featuredListController.followOrUnFollowEvent(
                      eventModel.id, modelIndex);
                },
                value: isFollowedByAuthUser,
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
                  animationsMap['toggleIconOnPageLoadAnimation1']!)
            ],
          ),
        ),
      ],
    );
  }
}
