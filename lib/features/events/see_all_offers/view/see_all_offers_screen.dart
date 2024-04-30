import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/toggle_icon.dart';
import '../../../../core/shared/widgets/images/network_image.dart';
import '../../../../core/utils/animation/shimmer_animation.dart';
import '../../../../core/utils/helper/date_formatter.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../home/model/offer_model.dart';
import '../controller/see_all_offers_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:easy_localization/easy_localization.dart';

class SeeAllOffersScreen extends StatelessWidget {
  SeeAllOffersScreen({super.key});
  final SeeAllOffersController seeAllOffersController =
      Get.put(SeeAllOffersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        surfaceTintColor: customColors.secondaryBackground,
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("Offers"),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(
                seeAllOffersController.hasMoreData.value
                    ? seeAllOffersController.itemList.length + 1
                    : seeAllOffersController.itemList.length, (index) {
              return index < seeAllOffersController.itemList.length
                  ? SeeAllOffersCard(
                      offerEvent: seeAllOffersController.itemList[index],
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
          ].divide(Divider(
            height: 30,
            thickness: 1,
            indent: 12,
            endIndent: 12,
            color: customColors.secondary,
          )),
        ),
      ),
    );
  }
}

class SeeAllOffersCard extends StatelessWidget {
  const SeeAllOffersCard(
      {super.key, required this.offerEvent, required this.modelIndex});
  final OfferEvent offerEvent;
  final int modelIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/eventDetailes', parameters: {
          'id': offerEvent.id.toString(),
        });
      },
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: customColors.secondaryBackground,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Align(
                alignment: const AlignmentDirectional(0, -1),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: getImageNetwork(
                              url: "/storage/${offerEvent.images[0]}",
                              width: double.infinity,
                              height: 400)),
                      Padding(
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
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              offerEvent.title,
                              style: customTextStyle.headlineSmall.override(
                                fontFamily: 'Nunito',
                                color: customColors.primary,
                                useGoogleFonts: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            DateFormatter.formatDate(offerEvent.startDate),
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.secondaryText,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                          ),
                          Text(
                            DateFormatter.formatTime(offerEvent.startDate),
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.secondaryText,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: false,
                            ),
                          ),
                        ].divide(const SizedBox(width: 5)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: customColors.secondaryText,
                            size: 15,
                          ),
                          SizedBox(
                            width: screenWidth * 0.25,
                            height: screenHeight * 0.03,
                            child: Marquee(
                              text: offerEvent.venue.governorate,
                              scrollAxis: Axis.horizontal,
                              blankSpace: 20.0,
                              velocity: 70.0,
                              pauseAfterRound: const Duration(seconds: 3),
                              style: customTextStyle.bodyMedium.override(
                                  useGoogleFonts: false,
                                  color: customColors.secondaryText,
                                  fontFamily: secondaryFontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ].divide(const SizedBox(height: 2)),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1, -1),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: customColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: GetBuilder<SeeAllOffersController>(
                          builder: (controller) {
                        return ToggleIcon(
                          onPressed: () async {
                            controller.followOrUnFollowEvent(
                                offerEvent.offer.eventId, modelIndex);
                          },
                          value: controller
                              .itemList[modelIndex].isFollowedByAuthUser,
                          onIcon: Icon(
                            Icons.favorite_sharp,
                            color: customColors.error,
                            size: 20,
                          ),
                          offIcon: Icon(
                            Icons.favorite_border,
                            color: customColors.primaryBackground,
                            size: 20,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
