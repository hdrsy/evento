import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/venue/controller/venue_controller.dart';
import 'package:evento/features/customize_event/venue/view/venue_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueScreen extends StatelessWidget {
   VenueScreen({super.key});
final VenueController venueController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          leading: InkWell(
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
        body: SizedBox(
          width: double.infinity,
          child: Obx(
            () => SingleChildScrollView(
                padding: padding(16, 20, 16, 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                       "Venue",
                        style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.primaryText,
                          fontSize: 25,
                          useGoogleFonts: true,
                        ),
                      ),
                      ...List.generate(
                              venueController.hasMoreData.value
                                  ? venueController.itemList.length + 1
                                  : venueController.itemList.length,
                              (index) {
                            return index <
                                    venueController.itemList.length
                                ? VenueCard(
                                    venue: venueController.itemList[index],
                                  )
                                : ShimmerLoadingWidget(loadingShimmerWidget:  Container(
                          width: double.infinity,
                          height: 300,
                          // height: 330 ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: customColors.info,
                            ),
                            color: customColors.info
                          ),
                        ));
                          })])),
          ),
        ));
  }
}