import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/model/organizer.dart';
import 'package:evento/features/events/home/view/widgets/column_text.dart';
import 'package:evento/features/events/home/view/widgets/home_loading_widget.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orgnizers extends StatelessWidget {
  Orgnizers({super.key});
  final OrganizerController organizerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => organizerController.isLoading.value
          ? const ShimmerLoadingWidget(
              loadingShimmerWidget: GridViewBuilderExample(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColumnText(
                  title: "Organizer",
                  subTitle: " Top Choices &  Highly Rated",
                  onTap: () {
                    Get.toNamed('/SeeAllOrganizersScreen');
                  },
                ),
                SizedBox(
                  height: scaleHeight(10),
                ),
                SizedBox(
                    // height: scaleHeight(350),
                    child: buildEventColumn())
              ],
            ),
    );
  }
}

// Main widget function for Column
Widget buildEventColumn() {
  final OrganizerController organizerController = Get.find();

  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          spacing: screenSize == ScreenSize.small
              ? 30
              : (screenSize == ScreenSize.medium ? 32 : 34),
          runSpacing: screenSize == ScreenSize.small
              ? 30
              : (screenSize == ScreenSize.medium ? 32 : 34),
          children: [
            ...List.generate(
                organizerController.itemList.length > 4
                    ? 4
                    : organizerController.itemList.length,
                (index) => buildEventItem(
                     organizerEvent: organizerController.itemList[index],modelIndex: index
                    ))
          ],
        ),
      ],
    ),
  );
}

// Function to create each event item
Widget buildEventItem({required OrganizerEvent organizerEvent,required int modelIndex}) {
  return InkWell(onTap: (){
    Get.toNamed('/OrganizerProfileScreen');
  },
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildEventImage('/storage/${organizerEvent.images[0]}'),
        buildEventTitle(organizerEvent.title),
        buildEventDateTime( "${DateFormatter.formatDate(organizerEvent.startDate)},${DateFormatter.formatTime(organizerEvent.startDate)}"),
      ],
    ),
  );
}

// Function to build the event image
Widget buildEventImage(String imagePath) {
  return InkWell(
    onTap: () {},
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: getImageNetwork(url: imagePath, width: screenSize == ScreenSize.small
            ? 120
            : (screenSize == ScreenSize.medium ? 150 : 160),
        height: screenSize == ScreenSize.small
            ? 120
            : (screenSize == ScreenSize.medium ? 150 : 160),)
      
      
     
    ),
  );
}

// Function to build the event title
Widget buildEventTitle(String title) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
    child: Text(
      title,
      style: customTextStyle.bodyMedium.override(
        fontFamily: breeSerif,
        color: customColors.primary,
        fontSize: screenSize == ScreenSize.small
            ? 12
            : (screenSize == ScreenSize.medium ? 14 : 16),
        useGoogleFonts: true,
      ),
    ),
  );
}

// Function to build the event date and time
Widget buildEventDateTime(String dateTime) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
    child: Text(
      dateTime,
      style: customTextStyle.bodySmall.override(
        fontFamily: breeSerif,
        fontSize: screenSize == ScreenSize.small
            ? 8
            : (screenSize == ScreenSize.medium ? 10 : 12),
        useGoogleFonts: true,
      ),
    ),
  );
}
