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
class FromYourCity extends StatelessWidget {
  final EventInYourCityListController eventInYourCityListController =
      Get.find();

  FromYourCity({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => eventInYourCityListController.isLoading.value
          ? ShimmerLoadingWidget(
              loadingShimmerWidget: inYourCityLoading(),
            )
          :  eventInYourCityListController.itemList.isEmpty?const SizedBox():
          
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColumnText(
                  title:tr( "Events in your city"),
                  subTitle: tr("Local Celebrations & Urban Vibes"),
                  onTap: () {
                    Get.toNamed('/seeAll', arguments: [
                      eventInYourCityListController.pageId,
                      eventInYourCityListController.itemList,
                      ServerConstApis.getInyourCityList,
                      "events_in_your_city",
                      "Events in your city"
                    ]);
                  },
                ),
                SizedBox(
                  height: scaleHeight(10),
                ),
                SizedBox(
                    // height: scaleHeight(350),
                    child: buildHorizontalListView())
              ],
            ),
    );
  }
}

// Main widget function for ListView
Widget buildHorizontalListView() {
  final EventInYourCityListController eventInYourCityListController =
      Get.find();

  return SingleChildScrollView(
      controller: eventInYourCityListController.scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              eventInYourCityListController.hasMoreData.value
                  ? eventInYourCityListController.itemList.length + 1
                  : eventInYourCityListController.itemList.length, (index) {
            return index < eventInYourCityListController.itemList.length
                ? buildEventCard(
                    eventInYourCityListController.itemList[index], index)
                : ShimmerLoadingWidget(
                    loadingShimmerWidget: Container(
                    width: 150,
                    height: 215,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: customColors.info,
                        ),
                        color: customColors.info),
                  ));
          }),
        ].divide(const SizedBox(
          width: 16,
        )),
      ));
}

// Function to create each event card
Widget buildEventCard(EventModel eventModel, int modelId) {
  return GetBuilder<EventInYourCityListController>(builder: (context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/eventDetailes', arguments: [eventModel.id,false,0]);
      },
      child: Container(
        width: 150,
        height: 215,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: customColors.secondaryBackground,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            buildEventImage(eventModel.images[0]),
            buildFavoriteIcon(
                eventModel.isFollowedByAuthUser, modelId, eventModel.id),
            buildEventText(
                eventModel.title,
                DateFormatter.formatDate(eventModel.startDate) +
                    DateFormatter.formatTime(eventModel.startDate)),
          ],
        ),
      ),
    );
  });
}

// Function to build the image section of the card
Widget buildEventImage(String imageUrl) {
  return InkWell(
    onTap: () {},
    child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: getImageNetwork(
            url: "/storage/$imageUrl",
            width: double.infinity,
            height: double.infinity)),
  );
}

// Function to build the favorite icon
Widget buildFavoriteIcon(
    bool isFollowedByAuthUser, int modelIndex, int eventId) {
  return Positioned(
    top: 0,
    right: 0,
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: ToggleIcon(
        onPressed: () {
          final EventInYourCityListController eventInYourCityListController =
              Get.find();
          eventInYourCityListController.followOrUnFollowEvent(
              eventId, modelIndex);
        },
        value: isFollowedByAuthUser,
        onIcon: Icon(Icons.favorite_sharp, color: customColors.error, size: 18),
        offIcon:
            Icon(Icons.favorite_border, color: customColors.info, size: 18),
      ),
    ),
  );
}

// Function to build the text content of the card
Widget buildEventText(String category, String dateTime) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 8),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.00, 1.00),
          child: Text(
            category,
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'BeerSerif',
              color: customColors.info,
              fontSize: screenSize == ScreenSize.small
                  ? 14
                  : (screenSize == ScreenSize.medium ? 16 : 18),
              useGoogleFonts: false,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1.00, 1.00),
          child: Text(
            dateTime,
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'BeerSerif',
              color: customColors.info,
              fontSize: 10,
              useGoogleFonts: false,
            ),
          ),
        ),
      ],
    ),
  );
}
