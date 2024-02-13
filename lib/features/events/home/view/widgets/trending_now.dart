import 'package:evento/core/shared/widgets/guest/guest_popup.dart';
import 'package:evento/core/shared/widgets/video/cards_video_widget.dart';
import 'package:evento/features/events/home/controller/event_state_manager.dart';

import '../../../../../core/responsive/helper_functions.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/server/server_config.dart';
import '../../../../../core/shared/widgets/buttons/toggle_icon.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
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
import 'package:share_plus/share_plus.dart';
import 'package:easy_localization/easy_localization.dart';

class TrendingNow extends StatelessWidget {
  TrendingNow({super.key});
  final TrendingListController trendingListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => trendingListController.isLoading.value
        ? ShimmerLoadingWidget(
            loadingShimmerWidget: featuredLoading(),
          )
        : trendingListController.itemList.isEmpty
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColumnText(
                    title: tr("Trending Now"),
                    subTitle: tr("Lively Gatherings & Illuminated Nights"),
                    onTap: () {
                      Get.toNamed('/seeAll', arguments: [
                        trendingListController.pageId,
                        trendingListController.itemList,
                        ServerConstApis.getTrendingList,
                        "trending_event",
                        "Trending Now"
                      ]);
                    },
                  ),
                  SizedBox(
                    height: scaleHeight(8),
                  ),
                  SizedBox(
                      // height: scaleHeight(350),
                      child: buildEventRow())
                ],
              ));
  }

// Main widget function
  Widget buildEventRow() {
    return SingleChildScrollView(
      controller: trendingListController.scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ...List.generate(
              trendingListController.hasMoreData.value
                  ? trendingListController.itemList.length + 1
                  : trendingListController.itemList.length, (index) {
            return index < trendingListController.itemList.length
                ? buildEventCard(
                    eventModel: trendingListController.itemList[index],
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
          width: 13,
        )),
      ),
    );
  }

// Function to create each event card
  Widget buildEventCard(
      {required EventModel eventModel, required int modelIndex}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/eventDetailes', arguments: [eventModel.id, false, 0]);
      },
      child: Container(
        width: screenWidth * 0.9,
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: customColors.primaryBackground,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildImageSection(eventModel),
              buildEventDetails(
                  eventModel.title,
                  DateFormatter.formatDate(eventModel.startDate),
                  DateFormatter.formatTime(eventModel.startDate),
                  modelIndex,
                  eventModel.id),
            ],
          ),
        ),
      ),
    );
  }

// Function to build the image section of the card
  Widget buildImageSection(EventModel eventModel) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 340,
        child: Stack(
          children: [
            buildImage(eventModel),
            buildPriceTag(eventModel.ticketPrice.toString()),
            buildSoundToggleButton()
          ],
        ),
      ),
    );
  }

// Function to build the image widget
  Widget buildImage(EventModel eventModel) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: eventModel.videos.isNotEmpty
            ? CardsVideoWidget(
                currentVideoUrl:
                    "${ServerConstApis.baseAPI}/storage/${eventModel.videos[0]}",
                videoHgiht: 240,
                videoWidth: double.infinity,
              )
            : getImageNetwork(
                url: "/storage/${eventModel.images[0]}",
                width: double.infinity,
                height: 240));
  }

// Function to build the price tag
  Widget buildPriceTag(String price) {
    return Positioned(
      bottom: 25,
      left: 10,
      child: Container(
        width: 100,
        height: 24,
        decoration: BoxDecoration(
          color: customColors.primaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: Text(
            "$price ${tr("sp")}",
            textAlign: TextAlign.center,
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'BeerSerif',
              color: customColors.primaryText,
              useGoogleFonts: false,
            ),
          ),
        ),
      ),
    );
  }

// Function to build the sound toggle button
  Widget buildSoundToggleButton() {
    return Positioned(
      bottom: 25,
      right: 10,
      child: ToggleIcon(
        onPressed: () {},
        value: false,
        onIcon: Icon(Icons.volume_off, color: customColors.info, size: 23),
        offIcon:
            Icon(Icons.volume_up_outlined, color: customColors.info, size: 23),
      ),
    );
  }

// Function to build the event details section
  Widget buildEventDetails(String eventName, String eventDate, String eventTime,
      int modelIndex, int eventId) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEventTitle(eventName, modelIndex, eventId),
          buildEventDate(eventDate),
          buildEventTimeAndArrow(
            eventTime,
          ),
        ],
      ),
    );
  }

// Function to build the event title
  Widget buildEventTitle(String eventName, int modelIndex, int eventId) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          eventName,
          style: customTextStyle.headlineSmall.copyWith(
            fontSize: 18,
          ),
        ),
        buildShareAndFavoriteIcons(modelIndex, eventId),
      ],
    );
  }

// Function to build the event date
  Widget buildEventDate(String eventDate) {
    return Text(
      eventDate,
      style: customTextStyle.bodyMedium.override(
        fontFamily: 'BeerSerif',
        color: customColors.primary,
        fontSize: 12,
        useGoogleFonts: false,
      ),
    );
  }

// Function to build the event time and forward arrow
  Widget buildEventTimeAndArrow(String eventTime) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          eventTime,
          style: customTextStyle.bodyMedium,
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(Icons.arrow_forward_outlined,
              color: customColors.secondaryText, size: responsiveIcon(25, 2)),
        ),
      ],
    );
  }

// Function to build share and favorite icons
  Widget buildShareAndFavoriteIcons(int modelIndex, int eventId) {
    return Row(
      children: [
        buildShareIcon(eventId),
        buildFavoriteToggleButton(modelIndex),
      ],
    );
  }

// Function to build the share icon
  Widget buildShareIcon(int eventId) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
      child: GestureDetector(
        onTap: () async {
          const String message = "Check out this event in Evento";
          final String url =
              "http://94.141.219.13:8003/#/eventDetailes/$eventId"; // Replace with your event link
          final String shareContent =
              "$message\n\nFor more details, visit: $url";

          await Share.share(shareContent);
        },
        child: Icon(
          Icons.share_rounded,
          color: customColors.secondaryText,
          size: responsiveIcon(25, 2),
        ),
      ),
    );
  }

// Function to build the favorite toggle button
  Widget buildFavoriteToggleButton(int modelIndex) {
    final EventStateManager eventStateManager = Get.find();
    return Obx(() {
      var eventModel = eventStateManager
          .getEventById(trendingListController.itemList[modelIndex].id)
          .value;

      return ToggleIcon(
        onPressed: () {
          if (isGuset) {
            Get.dialog(GuestPopupWidget());
          } else {
            trendingListController.followOrUnFollowEvent(
                trendingListController.itemList[modelIndex].id, modelIndex);
          }
        },
        value: eventModel.isFollowedByAuthUser,
        onIcon: Icon(Icons.favorite_sharp,
            color: customColors.error, size: responsiveIcon(25, 2)),
        offIcon: Icon(Icons.favorite_border,
            color: customColors.secondaryText, size: responsiveIcon(25, 2)),
      );
    });
  }
}
