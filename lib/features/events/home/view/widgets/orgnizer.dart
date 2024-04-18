import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/server/server_config.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/animation/shimmer_animation.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/home_controller.dart';
import '../../model/home_oganizer.dart';
import 'column_text.dart';
import 'home_loading_widget.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class Orgnizers extends StatelessWidget {
  Orgnizers({super.key});
  final HomeOrganizerController homeOrganizerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeOrganizerController.isLoading.value
          ? const ShimmerLoadingWidget(
              loadingShimmerWidget: GridViewBuilderExample(),
            )
          : homeOrganizerController.itemList.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColumnText(
                      title: tr("Organizer"),
                      subTitle: tr("Top Choices &  Highly Rated"),
                      onTap: () {
                        Get.toNamed('/SeeAllOrganizersScreen', arguments: [
                          homeOrganizerController.pageId,
                          homeOrganizerController.itemList,
                          ServerConstApis.getOrganizerHomeList,
                          "organizers",
                          "Organizers",
                        ]);
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
  final HomeOrganizerController homeOrganizerController = Get.find();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 32,
          runSpacing: 32,
          children: [
            ...List.generate(
                homeOrganizerController.itemList.length > 4
                    ? 4
                    : homeOrganizerController.itemList.length,
                (index) => buildOrganizerItem(
                    organizerHome: homeOrganizerController.itemList[index],
                    modelIndex: index))
          ],
        ),
      ],
    ),
  );
}

// Function to create each event item
Widget buildOrganizerItem({
  required OrganizerHome organizerHome,
  required int modelIndex,
}) {
  return GestureDetector(
      onTap: () {
        Get.toNamed('/OrganizerProfileScreen',
            arguments: [organizerHome.id, 0]);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEventImage(organizerHome.profile),
          buildEventTitle(organizerHome.name),
          // buildEventDateTime( "${DateFormatter.formatDate(organizerEvent.startDate)},${DateFormatter.formatTime(organizerEvent.startDate)}"),
        ],
      ));
}

// Function to build the event image
Widget buildEventImage(String imagePath) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: imagePath == ''
          ? Image.asset(
              'assets/images/faceBookProfile.jfif',
              // fit: BoxFit.,
              alignment: const Alignment(0, 0),
              width: 150,
              height: 150,
            )
          : imagePath.length > 6
              ? getImageNetworkforCahing(
                  url: '/storage/$imagePath',
                  width: 150,
                  height: 150,
                )
              : Image.asset(
                  'assets/images/${imagePath.substring(imagePath.length - 1)}.png',
                  width: 150,
                  height: 150,
                ));
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
