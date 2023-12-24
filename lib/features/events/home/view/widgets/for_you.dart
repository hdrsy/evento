import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/model/event_model.dart';
import 'package:evento/features/events/home/view/widgets/column_text.dart';
import 'package:evento/features/events/home/view/widgets/home_loading_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForYou extends StatelessWidget {
  ForYou({super.key});
  final JustForYouController justForYouController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => justForYouController.isLoading.value
          ? ShimmerLoadingWidget(
              loadingShimmerWidget: forYouLoading(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColumnText(
                  title: "Just for you",
                  subTitle: "Tailored Experiences & Personalized Picks",
                  onTap: () {
                    Get.toNamed('/seeAll', arguments: [
                      justForYouController.pageId,
                      justForYouController.itemList,
                      ServerConstApis.getJustForYouList,
                      "just_for_you",
                      "Just for you"
                    ]);
                  },
                ),
                SizedBox(
                  height: scaleHeight(10),
                ),
                SizedBox(
                    // height: scaleHeight(350),
                    child: buildHorizontalScrollEventCards())
              ],
            ),
    );
  }
}

// Main widget function for SingleChildScrollView
Widget buildHorizontalScrollEventCards() {
  final JustForYouController justForYouController = Get.find();

  return SingleChildScrollView(
    controller: justForYouController.scrollController,
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ...List.generate(
            justForYouController.hasMoreData.value
                ? justForYouController.itemList.length + 1
                : justForYouController.itemList.length, (index) {
          return index < justForYouController.itemList.length
              ? buildEventCard(justForYouController.itemList[index], index)
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
        }).divide(const SizedBox(
          width: 15,
        ))
      ],
    ),
  );
}

// Function to create each event card
Widget buildEventCard(EventModel eventModel, int modelIndex) {
  return GetBuilder<JustForYouController>(builder: (context) {
    return InkWell(
      onTap: (){  Get.toNamed('/eventDetailes',arguments: eventModel.id);
                    },
      child: Container(
        width: screenWidth * 0.45,
        // height: scaleHeight(210),
        decoration: BoxDecoration(
          color: customColors.primaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildEventImage(eventModel, modelIndex),
            buildEventText(eventModel.title,
                "${DateFormatter.formatDate(eventModel.startDate)},${DateFormatter.formatTime(eventModel.startDate)}"),
          ],
        ),
      ),
    );
  });
}

// Function to build the event image
Widget buildEventImage(EventModel eventModel, int modelIndex) {
  return Stack(
    children: [
      ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: getImageNetwork(
              url: "/storage/${eventModel.images[0]}",
              width: 200,
              height: 160)),
      Container(
        padding: const EdgeInsets.only(bottom: 10),
        width: 200,
        height: 160,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ToggleIcon(
                  onPressed: () async {
                    JustForYouController justForYouController = Get.find();
                    justForYouController.followOrUnFollowEvent(
                        eventModel.id, modelIndex);
                  },
                  value: eventModel.isFollowedByAuthUser,
                  onIcon: Icon(
                    Icons.favorite,
                    color: customColors.error,
                    size: 25,
                  ),
                  offIcon: Icon(
                    Icons.favorite_border,
                    color: customColors.info,
                    size: 25,
                  ),
                ),
              ],
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-0.98, 0.76),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                      child: Container(
                        width: 70,
                        height: 20,
                        decoration: BoxDecoration(
                          color: customColors.primaryBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: customColors.primaryBackground,
                          ),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Text(
                            "${eventModel.ticketPrice} s.p",
                            textAlign: TextAlign.center,
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 11,
                              useGoogleFonts: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}

// Function to build the event text
Widget buildEventText(String title, String dateTime) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle.bodyMedium.override(
            fontFamily: breeSerif,
            color: customColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            useGoogleFonts: true,
          ),
        ),
        Text(
          dateTime,
          style: customTextStyle.bodySmall.override(
            fontFamily: breeSerif,
            fontSize: 10,
            useGoogleFonts: true,
          ),
        ),
      ],
    ),
  );
}
