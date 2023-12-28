import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/features/events/event_detailes/model/event_detailes_model.dart';
import 'package:evento/features/events/event_detailes/view/widgets/inforamtion_event_widgets/amenities_section.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllAmenities extends StatelessWidget {
  SeeAllAmenities({super.key});
  final EventDetailesController eventDetailesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Amenities",
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: [
            Text(
              " Available  Amenities",
              style: customTextStyle.bodyMedium.override(
                  fontSize: 16,
                  color: customColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontFamily: primaryFontFamily,
                  useGoogleFonts: true),
            ),
            ...List.generate(
                eventDetailesController.eventDetailsModel.amenities.length,
                (index) => AmenitiesCard(
                      amenity: eventDetailesController
                          .eventDetailsModel.amenities[index],
                    ))
          ].divide(const SizedBox(height: 10,)),
        ),
      ),
    );
  }
}

class AmenitiesCard extends StatelessWidget {
  const AmenitiesCard({super.key, required this.amenity});
  final Amenity amenity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          amenity.title,
          style: customTextStyle.bodyMedium.override(
              fontSize: 14,
              color: customColors.secondaryText,
              fontWeight: FontWeight.w500,
              fontFamily: primaryFontFamily,
              useGoogleFonts: true),
        ),
        amentitesIcon(amenity.icon)
      ],
    );
  }
}
