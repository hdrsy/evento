import 'package:evento/core/const/share_event_and_app.dart';
import 'package:evento/core/utils/helper/number_formatter.dart';
import 'package:marquee/marquee.dart';

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
import 'package:easy_localization/easy_localization.dart';

class EventsFromOrganizer extends StatelessWidget {
  EventsFromOrganizer({super.key});
  final EventsforOrganizerListController eventsforOrganizerListController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => eventsforOrganizerListController.isLoading.value
        ? ShimmerLoadingWidget(
            loadingShimmerWidget: featuredLoading(),
          )
        : eventsforOrganizerListController.itemList.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColumnText(
                    title: tr("Organizer's Events"),
                    subTitle: tr("Curated Concerts & Exclusive Engagements"),
                    onTap: () {
                      Get.toNamed('/seeAll', arguments: [
                        eventsforOrganizerListController.pageId,
                        eventsforOrganizerListController.itemList,
                        ServerConstApis.getTrendingList,
                        "trending_event",
                        tr("Organizer's Events")
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
      controller: eventsforOrganizerListController.scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ...List.generate(
              eventsforOrganizerListController.hasMoreData.value
                  ? eventsforOrganizerListController.itemList.length + 1
                  : eventsforOrganizerListController.itemList.length, (index) {
            return index < eventsforOrganizerListController.itemList.length
                ? buildEventCard(
                    eventModel:
                        eventsforOrganizerListController.itemList[index],
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
        Get.toNamed('/eventDetailes', parameters: {
          'id': eventModel.id.toString(),
        });
      },
      child: Container(
        width: 355,
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
            buildImage(eventModel.images[0]),
            buildPriceTag(formatPrice(eventModel.ticketPrice)),
            eventModel.offer == null
            
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            color: customColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              "Offer",
                              textAlign: TextAlign.center,
                              style: customTextStyle.bodyMedium.override(
                                fontFamily: 'Nunito',
                                color: customColors.info,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: false,
                              ),
                            ).tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
            // buildSoundToggleButton(),
          ],
        ),
      ),
    );
  }

// Function to build the image widget
  Widget buildImage(String imagePath) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: getImageNetworkforCahing(
            url: "/storage/$imagePath", width: double.infinity, height: 240));
  }

// Function to build the price tag
  Widget buildPriceTag(String price) {
    return Align(
      alignment: const AlignmentDirectional(-1.00, 1.00),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
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
      ),
    );
  }

// Function to build the sound toggle button
  Widget buildSoundToggleButton() {
    return ToggleIcon(
      onPressed: () {},
      value: false,
      onIcon: Icon(Icons.volume_off,
          color: customColors.info,
          size: screenSize == ScreenSize.small
              ? 20
              : (screenSize == ScreenSize.medium ? 23 : 25)),
      offIcon: Icon(Icons.volume_up_outlined,
          color: customColors.info,
          size: screenSize == ScreenSize.small
              ? 20
              : (screenSize == ScreenSize.medium ? 23 : 25)),
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
        eventName.length > 20
            ? SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight * 0.03,
                child: Marquee(
                  text: eventName,
                  scrollAxis: Axis.horizontal,
                  blankSpace: 20.0,
                  velocity: 70.0,
                  pauseAfterRound: const Duration(seconds: 3),
                  style: customTextStyle.headlineSmall.copyWith(
                    fontSize: 18,
                  ),
                ),
              )
            : Text(
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
          await shareApp(eventId);
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
    return GetBuilder<EventsforOrganizerListController>(builder: (context) {
      return ToggleIcon(
        onPressed: () {
          eventsforOrganizerListController.followOrUnFollowEvent(
              eventsforOrganizerListController.itemList[modelIndex].id,
              modelIndex);
        },
        value: eventsforOrganizerListController
            .itemList[modelIndex].isFollowedByAuthUser,
        onIcon: Icon(Icons.favorite_sharp,
            color: customColors.error, size: responsiveIcon(25, 2)),
        offIcon: Icon(Icons.favorite_border,
            color: customColors.secondaryText, size: responsiveIcon(25, 2)),
      );
    });
  }
}
